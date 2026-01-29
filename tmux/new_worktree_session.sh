#!/bin/bash
# Creates a new git worktree and tmux session
# Usage: new_worktree_session.sh <name> [path]

set -e

NAME="$1"
WORK_DIR="${2:-$(pwd)}"

if [ -z "$NAME" ]; then
    echo "Error: No name provided"
    exit 1
fi

# Change to the working directory
cd "$WORK_DIR"

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Get the git root directory (handles both regular repos and worktrees)
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$GIT_ROOT" ]; then
    echo "Error: Could not determine git root"
    exit 1
fi

# Determine base branch (main or master)
if git show-ref --verify --quiet refs/heads/main; then
    BASE_BRANCH="main"
elif git show-ref --verify --quiet refs/heads/master; then
    BASE_BRANCH="master"
elif git show-ref --verify --quiet refs/remotes/origin/main; then
    BASE_BRANCH="origin/main"
elif git show-ref --verify --quiet refs/remotes/origin/master; then
    BASE_BRANCH="origin/master"
else
    echo "Error: Could not find main or master branch"
    exit 1
fi

# Create worktree path as sibling directory
PARENT_DIR=$(dirname "$GIT_ROOT")
WORKTREE_PATH="$PARENT_DIR/$NAME"

# Check if path already exists
if [ -e "$WORKTREE_PATH" ]; then
    echo "Error: Path already exists: $WORKTREE_PATH"
    exit 1
fi

# Create the worktree with a new branch
echo "Creating worktree '$NAME' from '$BASE_BRANCH'..."
git worktree add -b "$NAME" "$WORKTREE_PATH" "$BASE_BRANCH"

# Create new tmux session in the worktree directory
if tmux has-session -t "$NAME" 2>/dev/null; then
    echo "Warning: tmux session '$NAME' already exists, switching to it"
    tmux switch-client -t "$NAME"
else
    tmux new-session -d -s "$NAME" -c "$WORKTREE_PATH"
    tmux switch-client -t "$NAME"
fi

echo "Created worktree and session: $NAME"
