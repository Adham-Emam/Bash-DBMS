#!/bin/bash
function selectDB {
	clear
	while true; do
		if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
			echo "this user has no databases yet, please create one first."
			sleep 2
			dbMainMenu
			return
		fi
		echo "Available databases:"
		ls $DB_ROOT/$USERNAME | sed 's:/$::'
		read -p "enter the name of the database you want to connect to: " dbname

		connectedDB="$DB_ROOT/$USERNAME/$dbname"

		if [[ -d $connectedDB ]]; then
			clear
			export connectedDB
			echo "Connecting to $dbname..."
			sleep 2
			connectDB # Run the connectDB function
			return
		else
			echo "database not found."
			continue
		fi

	done
}