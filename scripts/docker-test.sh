#!/usr/bin/env bash
set -euo pipefail

# Build and test the devcontainer image
# Usage: ./scripts/docker-test.sh [image-tag]

IMAGE_TAG="${1:-dotfiles-test:local}"
CONTAINER_NAME="dotfiles-smoke-test"

echo "=== Building devcontainer image ==="
docker build -t "$IMAGE_TAG" -f .devcontainer/Dockerfile .

echo "=== Starting container ==="
docker run --rm -d --name "$CONTAINER_NAME" "$IMAGE_TAG" sleep 300

cleanup() {
  echo "=== Cleaning up ==="
  docker stop "$CONTAINER_NAME" 2>/dev/null || true
}
trap cleanup EXIT

echo "=== Running smoke tests in container ==="
docker exec "$CONTAINER_NAME" /home/dev/dotfiles/scripts/smoke-test.sh

echo "=== All tests passed ==="
