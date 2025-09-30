function selectFromTable {
    clear
    if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
        echo "No databases found, please create one first."
        sleep 2
        return 0
    fi

    if ! find "$connectedDB" -mindepth 1 -maxdepth 1 -type f | grep -q .; then
        echo "No tables found, please create one first."
        sleep 2
        return 0
    fi

    echo "Available tables:"
    ls "$connectedDB" | sed 's/\.[^.]*$//'

    while true; do
        read -p "Enter the name of the table you want to select from: " tableName
        if [[ -f "$connectedDB/$tableName.csv" ]]; then
            break
        else
            echo "Table not found."
        fi
    done

    selectColumns "$tableName"

    return 0
}
