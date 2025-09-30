function deleteFromTable {
    clear

    echo "Available tables:"
    ls "$connectedDB" | sed 's/\.[^.]*$//'

    read -p "Enter the name of the table you want to delete from: " tableName
    if [[ -f "$connectedDB/$tableName.csv" ]]; then

        clear
        echo "Table preview:"
        printf "    %s\n" "$(head -n 1 "$connectedDB/$tableName.csv")"
        tail -n +2 "$connectedDB/$tableName.csv" | nl -w2 -s". " | head -n 15
        echo "..."
        echo

        while true; do
            read -p "Enter the row number(s) to delete (comma-separated, skip header), or 'all' to clear table: " toDelete

            if [[ "$toDelete" == "all" ]]; then
                # Keep only the header
                sed -i '1!d' "$connectedDB/$tableName.csv"
                echo "✅ All rows deleted (header kept)."
                break
            elif [[ "$toDelete" =~ ^[0-9,]+$ ]]; then
                IFS=',' read -ra rows <<< "$toDelete"
                tmpFile=$(mktemp)

                # Keep header
                head -n 1 "$connectedDB/$tableName.csv" > "$tmpFile"

                # Copy all rows except the ones marked for deletion
                tail -n +2 "$connectedDB/$tableName.csv" | nl -w1 -s',' | while IFS=, read -r num line; do
                    skip=false
                    for r in "${rows[@]}"; do
                        if [[ $num -eq $r ]]; then
                            skip=true
                            break
                        fi
                    done
                    if ! $skip; then
                        echo "$line" >> "$tmpFile"
                    fi
                done

                mv "$tmpFile" "$connectedDB/$tableName.csv"
                echo "✅ Row(s) deleted successfully."
                break
            else
                echo "❌ Invalid input. Try again."
            fi
        done
    else
        echo "❌ Table '$tableName' not found."
    fi

    sleep 2
}