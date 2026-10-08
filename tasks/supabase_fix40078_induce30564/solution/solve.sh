#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `apps/studio/components/interfaces/Integrations/Queues/QueuesSettings.tsx`:

This pull request introduces the defect later reported as "Cannot access pgmq_public functions on local instance.". The
problem a user observed, and its root cause:

# Bug report

<!-- 

⚠️ We receive a lot of bug reports which have already been solved or discussed. If you are looking for help, please try these first:

- Docs: https://docs.supabase.com
- Discussions: https://github.com/supabase/supabase/discussions
- Discord: https://discord.supabase.com

Before opening a bug report, please verify the following: 

-->

- [x] I confirm this is a bug with Supabase, not with my own application. 
- [x] I confirm I have searched the [Docs](https://docs.supabase.com), GitHub [Discussions](https://github.com/supabase/supabase/discussions), and [Discord](https://discord.supabase.com). 

## Describe the bug

Cannot enable PostgREST for queues on local instance.

## To Reproduce

Steps to reproduce the behavior, please provide code snippets or a repository:

1. Log in to local instance of studio
1. Go to Integrations -> Queues -> Settings
2. Click on radio button "Expose Queues via PostgREST"
3. Click "Save Changes"
4. See error in the upper right

<img width="365" height="99" alt="Image" src="https://github.com/user-attachments/assets/01e17610-3bb9-4368-afb2-bed201610876" />

It appears that the `pgmq_public` schema is created even when seeing this error.

## Expected behavior

The `pgmq_public` schema is created and I can access its functions using the Supabase JS client.

(Note: this is what happens on the cloud-hosted instance. This error is only reproducible with a local instance.)

## Actual behavior

The `pgmq_public` schema is created and the functions are listed in the dashboard. However, even after creating a queue and updating its permissions to allow access, attempting to access the schema using the JavaScript client results in this error: "The schema must be one of the following: public, graphql_public"

The exact same edge function works fine on the cloud-base instance.

**System information**

 - Version of OS: Windows 11
 - Version of CLI: v2.30.4
 - Version of Docker: v4.40.0

```shell
$ npx supabase services


   SERVICE IMAGE          | LOCAL          
        | LINKED
  ------------------------|------------------------|--------
   supabase/postgres      | 17.4.1.048             | -
   supabase/gotrue        | v2.176.1               | -
   postgrest/postgrest    | v12.2.12               | -
   supabase/realtime      | v2.38.0                | -
   supabase/storage-api   | v1.24.7                | -
   supabase/edge-runtime  | v1.67.4                | -
   supabase/studio        | 2025.06.30-sha-6f5982d | -
   supabase/postgres-meta | v0.89.3                | -
   supabase/logflare      | 1.14.2         
        | -
   supabase/supavisor     | 2.5.6          
        | -
```

This same root cause must be fixed before merging.
REVIEW_EOF
