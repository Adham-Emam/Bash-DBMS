function selectColumns {
    clear
    echo "Available columns:"
    head -n 1 "$connectedDB/$tableName.csv" | tr ',' ' '

    # get headers into array
    IFS=',' read -ra headers <<< "$(head -n 1 "$connectedDB/$tableName.csv")"

    while true; do
        read -p "Enter the column names you want to select (comma-separated): " selectedColumns

        # normalize spaces → commas
        selectedColumns=$(echo "$selectedColumns" | tr -d ' ')

        # split user input into array
        IFS=',' read -ra selectedArray <<< "$selectedColumns"

        valid=true
        colIndexes=()

        # check each selected column exists in headers
        for col in "${selectedArray[@]}"; do
            found=false
            for i in "${!headers[@]}"; do
                if [[ "$col" == "${headers[$i]}" ]]; then
                    colIndexes+=($((i+1)))
                    found=true
                    break
                fi
            done
            if ! $found; then
                echo "❌ Column '$col' not found in table."
                valid=false
                break
            fi
        done

        if $valid; then
            break
        else
            echo "⚠️ Please try again with valid column names."
        fi
    done

    # Extract selected columns (space-separated, replace empty with "-")
    awk -F',' -v cols="$(IFS=','; echo "${colIndexes[*]}")" '{
        split(cols, arr, ",");
        out="";
        for (i in arr) {
            val=$((arr[i]));
            if (val == "") val="-";
            if (out == "") out=val;
            else out=out" "val;
        }
        print out;
    }' "$connectedDB/$tableName.csv"

    read -p "Press Enter to exit: "
}
