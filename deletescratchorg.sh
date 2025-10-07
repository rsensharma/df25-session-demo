#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Salesforce Scratch Org Deletion ---"

# Prompt the user for the alias of the scratch org to delete
read -p "Enter the alias of the scratch org you wish to DELETE: " org_to_delete

# Check if the user entered an alias
if [[ -z "$org_to_delete" ]]; then
    echo "Error: No scratch org alias was provided. Aborting deletion."
    exit 1
fi

echo "Attempting to delete scratch org with alias: $org_to_delete"

# Run the Salesforce CLI deletion command
# The '-o' flag specifies the target username or alias
sf org delete scratch -o "$org_to_delete" --no-prompt

echo "------------------------------------------------"
echo "Deletion command executed for org alias: $org_to_delete"

# Run the Salesforce CLI to list all org
sf org list