#!/bin/bash
echo "Welcome to Bash-DBMS"


# Check if databases directory exists
if [ ! -d "databases" ]; then
    mkdir databases
fi

# Check if users file exists
if [ ! -f "./databases/users.csv" ]; then
    touch ./databases/users.csv
fi

source auth.sh