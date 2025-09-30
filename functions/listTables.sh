function listTables {
    clear
    if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
        echo "No databases found, please create one first."
        sleep 2
        return 0
    else
        if ! find "$connectedDB" -mindepth 1 -maxdepth 1 -type f | grep -q .; then
            echo "No tables found, please create one first."
            sleep 2
            return 0
        fi
        echo "Available databases:"
        ls "$connectedDB" | sed 's/\.[^.]*$//'

        read -p "Press Enter to exit: "
        return 0
    fi
}
