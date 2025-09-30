function connectDB {
	while true; do
        clear
        echo "Connected to $(basename "$connectedDB")"

        echo "1) 📑 Create Table         - Define and create a new table"
        echo "2) 🗑️ Drop Table           - Delete an existing table"
        echo "3) 📋 List Tables          - Show all tables in the database"
        echo "4) ➕ Insert into Table    - Add a new record to a table"
        echo "5) 🔍 Select from Table    - Retrieve records from a table"
        echo "6) ❌ Delete Table Data    - Remove records from a table"
        echo "7) 🚪 Go Back              - Return to the previous menu"
	    echo "---------------------------------------------------------------------------------------"


        read -p "please choose one of the above options number (1-7): " choice

        case $choice in
            1)
                createTable ;;
            2)
                dropTable ;;
            3)
                listTables ;;
            4)
                insertIntoTable ;;
            5)
                selectFromTable ;;
            6)
                deleteTable ;;
            7)
                return ;;
            *)
                echo "invalid choice"
                sleep 2
                continue
                ;;
        esac
    done
}