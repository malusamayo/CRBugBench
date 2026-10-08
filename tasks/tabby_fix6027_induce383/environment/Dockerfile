FROM docker.io/malusamayo/swe-review-repo-tabby:v1

# Agent and judge CLIs from their official releases, installed ahead of the
# task's own layers so every task of a repository shares this layer.
ARG CODEX_VERSION=0.159.0
RUN curl -fsSL https://gh.io/copilot-install | bash \
    && mkdir -p /opt/codex \
    && curl -fsSL "https://github.com/openai/codex/releases/download/rust-v${CODEX_VERSION}/codex-package-$(uname -m)-unknown-linux-musl.tar.gz" \
       | tar -xz -C /opt/codex --exclude='codex-resources/voice' \
    && copilot --version && /opt/codex/bin/codex --version
ENV PATH="/opt/codex/bin:${PATH}"

WORKDIR /app/tabby

# The repo image (docker.io/malusamayo/swe-review-repo-tabby:v1) ships a full clone at /app/tabby. Pin it to the
# inducing PR's base commit (5b5d145bd05e56692607460d3453b8f1a134dc4c): history up to that commit is kept (so
# `git blame` / `git log` work), but every ref is deleted and a single fresh
# `main` is created at the base commit, so the fix and all later commits become
# unreachable and are pruned (no leakage) -- regardless of the repo's default
# branch name.
#
# The `.promisor` markers must go first: repo images are partial clones, and git
# never prunes objects in a promisor pack, so `git gc` alone leaves the whole
# future history (including the fix commit and its patch) readable by sha. The
# final check fails the build if any unreachable commit survived.
RUN set -eu; \
    git checkout --quiet --force --detach 5b5d145bd05e56692607460d3453b8f1a134dc4c; \
    for r in $(git remote); do git remote remove "$r"; done; \
    git for-each-ref --format='delete %(refname)' refs/heads refs/tags refs/remotes | git update-ref --stdin; \
    git switch --quiet -c main; \
    git reflog expire --expire=now --all; \
    rm -f .git/objects/pack/*.promisor; \
    git config --unset-all extensions.partialClone 2>/dev/null || true; \
    rm -f .git/objects/pack/tmp_pack_* .git/objects/pack/.tmp-*; \
    git repack -a -d --quiet; \
    git prune-packed; \
    git prune --expire=now; \
    total=$(git cat-file --batch-all-objects --batch-check='%(objecttype)' | grep -c '^commit$'); \
    reachable=$(git rev-list --count HEAD); \
    if [ "$total" != "$reachable" ]; then echo "LEAK: $total commit objects vs $reachable reachable from HEAD"; exit 1; fi

# The pull request under review.
COPY pr_to_review.diff /app/pr_to_review.diff
