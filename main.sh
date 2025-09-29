#!/bin/bash
echo "Welcome to Bash-DBMS"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DB_ROOT="$SCRIPT_DIR/databases"

for file in "./functions/"*.sh; do
    source "$file"
done


# Check if databases directory exists
if [ ! -d "$DB_ROOT" ]; then
    mkdir $DB_ROOT
fi

# Check if users file exists
if [ ! -f "$DB_ROOT/users.csv" ]; then
    touch $DB_ROOT/users.csv
fi

auth

dbMainMenu
