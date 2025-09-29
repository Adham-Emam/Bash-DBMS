#!/bin/bash
function showDB {
	clear
	if ! find "$DB_ROOT/$USERNAME" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
		echo "this user has no databases yet, please create one first."
		sleep 2
		dbMainMenu
	else
		ls $DB_ROOT/$USERNAME
	fi

	while true; do
		read  -p "Press \q to exit: " choice

		case $choice in
			q)
				dbMainMenu
			       	;;
			*)
				echo "invalid choice"
				;;
		esac
	done
}
