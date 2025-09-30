function insertIntoTable {
    clear
    if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
        echo "No databases found, please create one first."
        sleep 2
        return 0
    else
        echo "Available databases:"
        ls "$connectedDB" | sed 's/\.[^.]*$//'

        while true; do
            read -p "Enter the name of the table you want to insert into: " tableName
            if [[ -f "$connectedDB/$tableName.csv" ]]; then
                break
            else    
                echo "Table not found."
            fi
        done

        clear
        echo "Table columns:"
        head -n 1 "$connectedDB/$tableName.csv" | tr ',' ' '

        # get number of headers (columns)
        header=$(head -n 1 "$connectedDB/$tableName.csv")
        numCols=$(echo "$header" | awk -F',' '{print NF}')

        while true; do
            read -p "Enter the number of rows you want to insert: " numRows
            if [[ $numRows =~ ^[0-9]+$ ]]; then
                break
            else
                echo "Invalid input. Please enter a number."
            fi
        done

        for ((i=1; i<=$numRows; i++)); do
            while true; do
                read -p "Enter values for row $i (comma-separated, blanks allowed): " rowValues

                numValues=$(echo "$rowValues" | awk -F',' '{print NF}')

                if [[ $numValues -eq $numCols ]]; then
                    break
                else
                    echo "⚠️ Invalid input: expected $numCols values, got $numValues"
                    echo "   You can leave values empty but must keep the commas."
                    echo "   Example: if $numCols columns → val1,,val3"
                fi
            done

            echo "$rowValues" >> "$connectedDB/$tableName.csv"
        done

        echo "Rows inserted successfully."
        sleep 2
    fi
}
