# Code Review Task

You are a maintainer reviewing a pull request to the `alibaba/spring-ai-alibaba` repository.

**PR title:** feat(memories): support redis memory the underlying implementation of jedis, lettuce, and redisson in both standalone and cluster modes

**PR description:**

### Describe what this PR does / why we need it
- Support redis memory using mainstream jedis, lettuce, and redisson clients, and support redis memory configuration for **both standalone and clusters**
- Support the autoConfiguration `ChatMemoryRepository`  of redis memory jedis, lettuce, and redisson
- In `application.yaml`, standalone and cluster connection configurations are provided, along with a switchable client-type underlying redis client implementation
- Support custom overwriting of core configuration items for different ChatMemoryRepository, such as pooling config

### Describe how you did it
- Based on `spring-data-redis`, the standalone and cluster modes of jedis、lettuce、redisson are constructed and applicable to redis memory
- Standalone configuration to `RedisMemoryStandaloneConfiguration`, cluster configuration to `RedisMemoryClusterConfiguration`, By abstracting the superclass `RedisMemoryConnectionConfiguration` unified three client standalone and cluster configuration access method

### Basic configuration - Standalone

```yaml
spring:
  ai:
    memory:
      redis:
        host: localhost
        port: 6379
```

### Basic configuration - Cluster

```yaml
spring:
  ai:
    memory:
      redis:
        cluster:
          nodes: localhost:6379,localhost:6380,localhost:6381
```

### Switch the redis client

```yaml
spring:
  ai:
    memory:
      redis:
        # Supports jedis, lettuce, and redisson
        client-type: jedis
        cluster:
          nodes: localhost:6379,localhost:6380,localhost:6381
```

### Full configuration - Standalone
```yaml
spring:
  ai:
    memory:
      redis:
        # Supports jedis, lettuce, and redisson
        client-type: jedis
        host: localhost
        port: 6379
        username: yourUsername
        password: yourPassword
        timeout: 2000
```

### Full configuration - Cluster
```yaml
spring:
  ai:
    memory:
      redis:
        username: yourUsername
        password: yourPassword
        timeout: 2000
        # Supports jedis, lettuce, and redisson
        client-type: jedis
        cluster:
          nodes: localhost:6379,localhost:6380,localhost:6381
```
### Describe how to verify it
The result of the integration test is
Jedis
<img width="475" height="250" alt="jedis" src="https://github.com/user-attachments/assets/cdecc087-6cf3-49f9-af1e-034f4fa49c9a" />
Lettuce
<img width="479" height="249" alt="lettuce" src="https://github.com/user-attachments/assets/6a4225dc-4874-4d92-9e50-381f3628cd06" />
Redisson
<img width="471" height="244" alt="redisson" src="https://github.com/user-attachments/assets/db560e1a-6d3e-46a4-a0ea-c69a2b8284c5" />

## Working environment

The repository is checked out at `/app/spring-ai-alibaba` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
