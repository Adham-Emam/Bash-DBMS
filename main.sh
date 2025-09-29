#!/bin/bash
echo "Welcome to Bash-DBMS"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DB_ROOT="$SCRIPT_DIR/databases"

for file in "./functions/"*.sh; do
    source "$file"
done


# Check if databases directory exists
if [ ! -d "databases" ]; then
    mkdir databases
fi

# Check if users file exists
if [ ! -f "./databases/users.csv" ]; then
    touch ./databases/users.csv
fi

# auth

dropDB
