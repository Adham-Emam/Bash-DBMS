#!/bin/bash
function selectDB {
	clear
	read -p "enter the name of the database you want to connect to: " dbname
	if [[ -z $dbname ]]; then
		bash dbMainMenu.sh
		return
	fi

	validateDBName "$dbname"
	if [[ $? -ne 0 ]]; then
		return
	fi
}