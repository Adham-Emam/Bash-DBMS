#!/bin/bash
function dbMainMenu {
	while true; do
		clear
		echo "1) 📂 Select Database       - Connect to an existing database"
        echo "2) ➕ Create Database       - Create a new database"
        echo "3) ✏️ Rename Database        - Rename an existing database"
        echo "4) 🗑️ Drop Database         - Delete an existing database"
        echo "5) 🗃️ Show Databases        - Show all existing databases"
       	echo "6) 🚪 Logout                  - Go back to registration menu"
		echo "---------------------------------------------------------------------------------------"
		read -p "please choose one of the above options number (1-7): " choice

		case $choice in
			1)
				selectDB ;;
			2)
				createDB ;;
			3)
				renameDB ;;
			4)
				dropDB ;;
			5)
				showDB ;;
			6)
				clear
				echo "exiting bye bye"
				sleep 2 
				auth ;;
			*)
				echo "❌ Invalid choice, returning to welcome screen..."
				sleep 2
		esac
	done
}
