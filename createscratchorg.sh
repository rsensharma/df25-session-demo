#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- 1. Create a 10-character random alias ---
# Generates 10 random characters (a-z, A-Z, 0-9)
# The 'tr -dc' command deletes all characters EXCEPT those specified in the set.
# The 'head -c 10' limits the output to 10 characters.
org_alias=$(LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 10)

echo "Generated scratch org alias: $org_alias"
echo "-----------------------------------"

# --- 2. Run the Salesforce CLI command ---
echo "Creating new scratch org..."

# The sf command uses the generated $org_alias
sf org create scratch \
    --definition-file config/project-scratch-def.json \
    --set-default \
    --duration-days 7 \
    --alias "$org_alias"

# --- 3. Display the final alias (for verification) ---
echo "-----------------------------------"
echo "Scratch org creation command complete. Happy demoing!!"
echo "Your new default scratch org alias is: $org_alias"

# Run the Salesforce CLI to list all org
sf org list