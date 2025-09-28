#!/bin/bash
function showDBS {
	clear
	if [[ ! -d "databases/$USERNAME" ]]; then
		echo "this user has no databases yet, please create one first."
	else
		ls databases/$USERNAME
	fi

	while true; do
		read  -p "Press q to exit" choice

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
