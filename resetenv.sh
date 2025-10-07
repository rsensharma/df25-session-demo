#!/bin/bash

# A simple script to create, commit to, and then delete a temporary branch.

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Create a new branch named 'deleteme' and switch to it.
echo "--- Refresh the Local File System ---"
echo "Creating and switching to the 'deleteme' branch..."
git checkout -b deleteme

# 2. Stage all files.
echo "Staging all files..."
git add -A

# 3. Commit all staged files.
echo "Committing all staged files..."
# Check if there are any changes to commit to avoid an error.
if git diff --cached --exit-code --quiet; then
    echo "No changes to commit. Skipping commit."
else
    git commit -m "chore: temporary commit"
fi

# 4. Check out the main branch.
# This assumes your main development branch is named 'main'.
# If you use 'master', you'll need to change this line.
echo "Checking out the main branch..."
git checkout main

# 5. Delete the 'deleteme' branch.
echo "Deleting the 'deleteme' branch..."
# The -D flag forces deletion even if the branch isn't fully merged.
git branch -D deleteme

# 6. Ask the user if they want to create a scratch org.
echo "Script completed successfully."