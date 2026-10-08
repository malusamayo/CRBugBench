FROM docker.io/malusamayo/swe-review-repo-scrapy:v1

# Agent and judge CLIs from their official releases, installed ahead of the
# task's own layers so every task of a repository shares this layer.
ARG CODEX_VERSION=0.159.0
RUN curl -fsSL https://gh.io/copilot-install | bash \
    && mkdir -p /opt/codex \
    && curl -fsSL "https://github.com/openai/codex/releases/download/rust-v${CODEX_VERSION}/codex-package-$(uname -m)-unknown-linux-musl.tar.gz" \
       | tar -xz -C /opt/codex --exclude='codex-resources/voice' \
    && copilot --version && /opt/codex/bin/codex --version
ENV PATH="/opt/codex/bin:${PATH}"

WORKDIR /app/scrapy

# The repo image ships a full clone at /app/scrapy. Pin it to this PR's base
# commit (a3d38041e230f886d55569f861a11a96ab8a1913): history up to that commit is kept (so `git blame` /
# `git log` work), but every ref is deleted and a single fresh `main` is created
# at the base commit, so the PR head and all later commits become unreachable and
# are pruned (no leakage) -- regardless of the repo's default branch name.
#
# The `.promisor` markers must go first: repo images are partial clones, and git
# never prunes objects in a promisor pack, so `git gc` alone leaves the whole
# future history (including the PR's merge commit) readable by sha. The final
# check fails the build if any unreachable commit survived.
RUN set -eu; \
    git checkout --quiet --force --detach a3d38041e230f886d55569f861a11a96ab8a1913; \
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

# The pull request under review (base -> the reviewed commit). Provided two ways
# so both prompt-based and diff-native review agents work:
#   * as a unified diff file at /app/pr_to_review.diff, and
#   * applied as uncommitted modifications to the working tree.
COPY pr_to_review.diff /app/pr_to_review.diff
RUN git apply --whitespace=nowarn /app/pr_to_review.diff \
    && git add -N . \
    && git --no-pager diff --stat
