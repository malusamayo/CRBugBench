#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `backend/open_webui/retrieval/vector/dbs/s3vector.py`:

This pull request introduces the defect later reported as "issue: S3 Vectors has_collection() fails for indexes beyond first page due to missing pagination". The
problem a user observed, and its root cause:

### Check Existing Issues

- [x] I have searched for any existing and/or related issues.
- [x] I have searched for any existing and/or related discussions.
- [x] I have also searched in the CLOSED issues AND CLOSED discussions and found no related items (your issue might already be addressed on the development branch!).
- [x] I am using the latest version of Open WebUI.

### Installation Method

Docker

### Open WebUI Version

v0.6.36

### Ollama Version (if applicable)

_No response_

### Operating System

AWS ECS

### Browser (if applicable)

_No response_

### Confirmation

- [x] I have read and followed all instructions in `README.md`.
- [x] I am using the latest version of **both** Open WebUI and Ollama.
- [x] I have included the browser console logs.
- [x] I have included the Docker container logs.
- [x] I have **provided every relevant configuration, setting, and environment variable used in my setup.**
- [x] I have clearly **listed every relevant configuration, custom setting, environment variable, and command-line option that influences my setup** (such as Docker Compose overrides, .env values, browser settings, authentication configurations, etc).
- [x] I have documented **step-by-step reproduction instructions that are precise, sequential, and leave nothing to interpretation**. My steps:
- Start with the initial platform/version/OS and dependencies used,
- Specify exact install/launch/configure commands,
- List URLs visited, user input (incl. example values/emails/passwords if needed),
- Describe all options and toggles enabled or changed,
- Include any files or environmental changes,
- Identify the expected and actual result at each stage,
- Ensure any reasonably skilled user can follow and hit the same issue.


### Expected Behavior

When using S3 Vectors for RAG storage, the `has_collection()` method should correctly detect if a vector index exists, regardless of how many total indexes exist in the bucket.

When uploading a file and then querying it:
1. File uploads successfully
2. Vector index is created
3. RAG queries can find and use the indexed content

### Actual Behavior

When the S3 Vectors bucket contains more than approximately 1,000 indexes:
- Newly created indexes are reported as "not found"
- RAG queries return "No sources found" despite successful index creation
- Logs show: `WARNING | Collection 'file-<uuid>' does not exist`
- The issue persists even 15+ minutes after index creation

**Pattern observed:**
- ✅ Below ~1,000 total indexes: Retrieval works correctly (collection is found)
- ❌ Above ~1,000 total indexes: Collections beyond the first ~1,000 are not found
- ✅ Direct AWS API calls confirm indexes exist

### Steps to Reproduce

#### Environment Setup

**Platform:** AWS ECS Fargate (or any Docker deployment)
**Open WebUI Version:** v0.6.36
**Docker Image:** `ghcr.io/open-webui/open-webui:v0.6.36`

**Required Environment Variables:**
```bash
# S3 Vectors Configuration (only relevant configs)
RAG_EMBEDDING_ENGINE=s3vectors
AWS_S3_VECTOR_BUCKET_NAME=your-vector-bucket-name
AWS_REGION=us-west-2  # or your preferred region
AWS_ACCESS_KEY_ID=<your-access-key>
AWS_SECRET_ACCESS_KEY=<your-secret-key>

# Standard configs (database, API keys, etc.)
DATABASE_URL=postgresql://user:pass@db-host:5432/openwebui
```

**Docker Run Command:**
```bash
docker run -d \
  --name open-webui \
  -p 3000:8080 \
  -e RAG_EMBEDDING_ENGINE=s3vectors \
  -e AWS_S3_VECTOR_BUCKET_NAME=your-vector-bucket-name \
  -e AWS_REGION=us-west-2 \
  -e AWS_ACCESS_KEY_ID=<your-access-key> \
  -e AWS_SECRET_ACCESS_KEY=<your-secret-key> \
  -e DATABASE_URL=postgresql://user:pass@db-host:5432/openwebui \
  -v open-webui:/app/backend/data \
  ghcr.io/open-webui/open-webui:v0.6.36
```

**AWS S3 Vectors Bucket Setup:**
```bash
# Create S3 Vectors bucket (if not exists)
aws s3vectors create-bucket \
  --bucket-name your-vector-bucket-name \
  --region us-west-2
```

**IAM Permissions Required:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3vectors:*"
      ],
      "Resource": "*"
    }
  ]
}
```

#### Creating the Prerequisite State (1,000+ Indexes)

**Option 1: Upload 1,000 files through UI** (time-consuming but realistic)
- Upload 1,000+ different files through the workspace
- Each file creates one index

**Option 2: Script to create test indexes** (faster for reproduction)
```python
import boto3
import uuid

client = boto3.client('s3vectors', region_name='us-west-2')
bucket_name = 'your-vector-bucket-name'

# Create 1,050 test indexes
for i in range(1050):
    index_name = f"test-index-{uuid.uuid4()}"
    client.create_index(
        vectorBucketName=bucket_name,
        indexName=index_name,
        dimension=1536,
        distanceMetric='cosine'
    )
    if i % 100 == 0:
        print(f"Created {i} indexes...")
```

#### Reproduction Steps

**Step 1: Verify container is running**
```bash
docker logs open-webui --tail 50
# Expected: No errors, server started on port 8080
# Actual: Server running normally
```

**Step 2: Access Open WebUI**
- Navigate to `http://localhost:3000` (or your deployment URL)
- Log in with admin credentials
- **Expected:** Dashboard loads successfully
- **Actual:** Dashboard loads successfully ✓

**Step 3: Create test file**
Create a test file `test-document.txt` with content:
```
This is a test document for vector search.
It contains information about quantum computing and artificial intelligence.
The quantum computing section discusses qubits and superposition.
```

**Step 4: Upload file to workspace**
- Click "Workspace" in left sidebar
- Click "Knowledge" tab
- Click "+ Add Knowledge" button
- Select "Upload Files"
- Choose `test-document.txt`
- Click "Upload"
- **Expected:** File uploads, shows "Processing..." then "Completed"
- **Actual:** File shows "Completed" status ✓

**Step 5: Monitor logs during upload**
```bash
docker logs -f open-webui | grep -E "(Created S3 index|Completed insertion|Collection)"
```
**Expected:**
```
INFO | Created S3 index: file-abc123def456
INFO | Completed insertion of 15 vectors
```
**Actual:** Same as expected ✓

**Step 6: Wait for indexing to complete**
- Wait 60 seconds (well beyond typical indexing time)
- **Expected:** Index should be queryable after ~10 seconds
- **Actual:** Waited 60 seconds

**Step 7: Verify index exists via AWS CLI**
```bash
# Get the file UUID from logs (e.g., "abc123def456")
aws s3vectors get-index \
  --vector-bucket-name your-vector-bucket-name \
  --index-name file-abc123def456 \
  --region us-west-2
```
**Expected:** Error (index doesn't exist)
**Actual:** Returns index details - index EXISTS! ✓
```json
{
  "index": {
    "indexName": "file-abc123def456",
    "creationTime": "2024-01-15T10:30:00Z",
    "dimension": 1536,
    "distanceMetric": "cosine"
  }
}
```

**Step 8: Query the uploaded file**
- Click "New Chat" in left sidebar
- In chat input, type: `What does the document say about quantum computing?`
- Press Enter
- **Expected:** Response citing the uploaded document with quote about qubits
- **Actual:** Response says "I don't have any specific information about quantum computing in the uploaded documents" with message "No sources found" ❌

**Step 9: Check logs for warnings**
```bash
docker logs open-webui | grep -i "collection.*does not exist"
```
**Expected:** No warnings
**Actual:** Multiple warnings ❌
```
WARNING | Collection 'file-abc123def456' does not exist
WARNING | Collection 'file-abc123def456' does not exist
WARNING | Collection 'file-abc123def456' does not exist
```

**Step 10: Verify total index count**
```bash
# Count total indexes in bucket
aws s3vectors list-indexes \
  --vector-bucket-name your-vector-bucket-name \
  --region us-west-2 \
  --output json | jq '.indexes | length'
```
**Expected:** Any number
**Actual:** Returns `1000` (or close to it), and response includes `"nextToken": "..."` indicating pagination ❌

#### Key Observations

1. **Index creation succeeds** - lo

This same root cause must be fixed before merging.
REVIEW_EOF
