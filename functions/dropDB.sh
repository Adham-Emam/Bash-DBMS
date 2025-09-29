#!/bin/bash

dropDB() {
    clear
    if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
        echo "No databases found, please create one first."
        sleep 2
        dbMainMenu
    else
        cd "$DB_ROOT/$USERNAME"
        echo "Available databases:"
        ls -d */ | sed 's:/$::'

        while true; do
            read -p "Enter the name of the database you want to delete: " dbName
            if [[ -d "$dbName" ]]; then
                while true; do
                    read -s -p "Enter password to delete the database: " password
                    echo

                    # Hash the password
                    login_hash=$(printf "%s" "$password" | sha256sum | awk '{print $1}')

                    if grep -q "^$USERNAME:$login_hash$" "$DB_ROOT/users.csv"; then
                        break 2
                    else
                        echo "Invalid password"
                    fi
                done
            else
                echo "Database not found."
            fi
        done

        rm -r "$dbName"
        cd "$SCRIPT_DIR"
        clear
        echo "Database deleted successfully."
        db
    fi
}

dropDB
