# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** feat(new source): Initial `kubernetes_logs` implementation (#2653)

**PR description / commit message:**

feat(new source): Initial `kubernetes_logs` implementation (#2653)

* Add kubernetes-integration-tests feature

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Enable kubernetes tests

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add skaffold for quick development iterations

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add kubernetes mod and cargo feature

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add an HTTP client tailored for k8s API in an in-cluster environment

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a decoder for chained k8s responses

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add block_on_std to test_util

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add tools for processing HTTP bodies as streams of k8s responses

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add Watcher trait

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add ApiWatcher implementation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add MockWatcher implementation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a reflector implementation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a placeholder for kubernetes logs source

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add paths provider implementation based on pods state driven by reflector

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add parser for k8s log formats

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add partial events merger

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add pod metadata annotator

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add kubernetes logs source implementation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Change reflector errors to be less restrictive

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Better error handling

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Improve error handling

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Better error handling for event pipeline

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Abstract API watcher around watch request builder

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add assertions to the reflector internal state in-between the invocations

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix the comment at optional tranform mod

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a to do comment to make transform utils part of core

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix typo at kustomization.yaml

Signed-off-by: MOZGIII <mike-n@narod.ru>

* More flexible interface at resource version

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix the mod comment at resource version

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Remove manual minikube init from scripts/skaffold.sh

Skaffold is capable of detecting minikube itself. It will also work with
Docker Desktop on Windows and macOS out of the box.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Specify shell at scripts/minikube-docker-env.sh

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch scripts/copy-docker-image-to-minikube.sh to use scripts/minikube-docker-env.sh

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch to using device inodes for file fingerprinting

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix grammar at in-cluster config

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add the variable that's missing to the error at in-cluster config

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Move in_cluster mod declaration to the top of the file

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Cut some ununsed code from src/kubernetes/resource_version.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix typo at src/kubernetes/reflector.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Move the file key to the top of the file

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix comment at parsers test

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a comment for Config::self_node_name

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Allow disabling automatic partial merge

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Allow customizing the fields names used by pod metadata annotator

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Abstract reflector around state

Adds an indirection layer while maintaining the same logic.

This unlocks:
- adding debounce to the evmap for advanced state management;
- adding removal delay to mitigate the race condition with pod being
  removed while having a huge log backlog;
Those were doable before, but at the cost of code clarity, reliability and
maintainability.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add support for delayed delete at reflector

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Reimplement the tests to add delayed deletion testing capability

New channel-based mocks implementation allows to properly eliminate race
conditions and achieve the complete determinism and reliability of the
test scenario.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Improve the request preparation code at kubernetes::client::Client

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add reexports at src/kubernetes/mod.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Adjust and use watcher error constructors

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Eliminate unused transform

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a test for stream error behavior

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add tests and derives at transform::util::pick

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Require Watcher::Stream to be Send

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add instrumentation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add state maintenance and move delayed delete logic into to a state wrapper

This unlocks further complicating the logic around state without making
reflector overcomplicated. This better aligns with the goal of building
composable and testable loosely coupled components.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Ignore instrumenting state tests

There no way to assert individual emits, and asserting metrics directly
causes issues:
- these tests break the internal tests at the metrics implementation
  itself, since we end up initializing the metrics controller twice;
- testing metrics introduces unintended coupling between subsystems,
  ideally we only need to assert that we emit, but avoid assumptions on
  what the results of that emit are.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Clean up reflector tests

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add flush debouncing to the evmap state

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Proper delay control at main test flow

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add evmap tests with and without debounce

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix a typo

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Document the controversial join_host_port

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Improve instrumenting watcher events

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Improve api watcher events

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Rename init to new

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Use Strings at parser tests

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Corrected partial message detection hueristics at docker parser

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Hint for where's what at parser test case

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Bump base image at skaffold/docker/Dockerfile to debian:bullseye-slim

Without it local builds don't work host OS' with glibc 2.29

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Better script layout at skaffold/docker/Dockerfile

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Convert an annotation failure warn log to internal event

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Correct the shutdown logic

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Specify STOPSIGNAL at skaffold/docker/Dockerfile

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Set terminationGracePeriodSeconds at distribution/kubernetes/vector-namespaced.yaml

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix paths generation on Windows

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a to do to unignore instrumenting state tests

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add Kubernetes section to the CONTRIBUTING.md

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Solve the issue with the config generation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Better document the intent for the kubernetes_logs source

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Print vector version upon docker build at skaffold/docker/Dockerfile

This is so that we catch the error with inability to exec vector at
container build time, rather than at runtime.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add more build-time output at skaffold/docker/Dockerfile

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add patchelf at skaffold/docker/Dockerfile

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Optimize commands order at skaffold/docker/Dockerfile for layer caching

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add kubectl at CONTRIBUTING.md

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add additional details at CONTRIBUTING.md

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix the data dir description

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Move transform utils to the source mod to avoid introducing global items

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix the typo at CONTRIBUTING.md

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Eliminate the ApiWatcher::invoke_boxed_stream

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add code docs for join_host_port

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a lifecycle system to manage futures sanely and reliably

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Reorganized the mod and use clauses at src/sources/kubernetes_logs/mod.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch fingerprinter to checksum

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Revert "Switch fingerprinter to checksum"

Apparently it breaks everything. E2E tests start failing.
We need a better way.

This reverts commit a4c2a7d88d0f06d70da9738518ae74b30a6fb835.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Invert the condition at Debounce::signal

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix typo at src/internal_events/kubernetes/instrumenting_state.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Remove the rate limit from KubernetesLogsEventReceived

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Adjust the log style at KubernetesLogsEventReceived

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Move pod metadata annotation to access file path directly

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add test to ensure MultiResponseDecoder doesn't leak memory

It was controversial, and so this test is added.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Simplified the picker logic and added tests

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a special case for `\n` at the MultiResponseDecoder::finish

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Workaround for watch API failures

This should've been fixed by now, but it's still causing issues with older
k8s versions that we want to support.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a long line test case for the CRI format parser

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Log the buffer state at response decoding error

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Handle data parsing errors as stream ends

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Ensure we only read logs under container name subdirectory

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Promote trace to an error at src/kubernetes/multi_response_decoder.rs

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Add a test case for bookmark parsing error

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Remove meaningless leading \n from the boorkmark test

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Update k8s-openapi to a branch with a fix for the bookmark parsing issue

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch kubernetes_logs source to Fingerprinter::FirstLineChecksum

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Revert "Handle data parsing errors as stream ends"

This reverts commit c0e1695b8757a3d67cd8e0722c38be724775bd5e.

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch k8s-openapi git repo to our fork

No actual changes there compared to upstream, just for preservation

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Use cargo patch instead of per-crate git spec for k8s-openapi

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Switch to the upstream of k8s-openapi

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Fix clippy offences

Signed-off-by: MOZGIII <mike-n@narod.ru>

* Bump k8s-openapi and switch to crates.io version

Signed-off-by: MOZGIII <mike-n@narod.ru>

## Working environment

The repository is checked out at `/app/vector` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
