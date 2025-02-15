#!/bin/bash

echo "🚀 Starting CI/CD Pipeline..."

# Define GITHUB_REPOSITORY manually if running locally
if [[ -z "$GITHUB_REPOSITORY" ]]; then
  GITHUB_REPOSITORY=$(git remote get-url origin | sed 's/.*github.com[:/]//;s/.git$//')
fi

# Get repository name
REPO_NAME=$(basename "$GITHUB_REPOSITORY")

# Check if repo name contains spaces
if [[ "$REPO_NAME" =~ \  ]]; then
  echo "❌ ERROR: Repository name contains spaces!"
  exit 1
fi

# Get latest commit message
COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# Ensure commit message follows guidelines
if [[ "$COMMIT_MESSAGE" == *"WIP"* ]]; then
  echo "❌ ERROR: Commit message contains 'WIP'. Please finalize it!"
  exit 1
fi

echo "✅ Repository and commit check passed."
