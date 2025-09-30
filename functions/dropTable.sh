function dropTable {
    clear
    if ! find "$connectedDB" -mindepth 1 -maxdepth 1 -type f | grep -q .; then
        echo "No tables found, please create one first."
        sleep 2
        connectDB
    else
        echo "Available tables:"
        ls "$connectedDB" | sed 's/\.[^.]*$//'

        while true; do
            read -p "Enter the name of the table you want to Drop: " tableName
            if [[ -f "$connectedDB/$tableName.csv" ]]; then
                while true; do
                    read -s -p "Enter password to Drop the table: " password
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
                echo "Table not found."
            fi
        done

        rm "$connectedDB/$tableName.csv"
        echo "Table Dropped successfully."
        sleep 2
    fi
}
