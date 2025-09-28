#!/bin/bash
echo "Welcome to Bash-DBMS"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DB_MAIN_DIR="$SCRIPT_DIR/Databases"

for file in "$SCRIPT_DIR/functions/"*.sh; do
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


createDB