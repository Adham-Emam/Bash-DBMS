#!/bin/bash
function createDB {
	clear
	while true; do
		read -p "enter the name of the database you want to create or type \q to exit: " dbname
		if [[ $dbname == "q" ]]; then
			dbMainMenu
			return 0
		fi
		if  ! validateDBName "$dbname"; then
			continue
		fi
		if [[ ! -d "databases/$USERNAME" ]]; then
			mkdir databases/$USERNAME
		fi
		if [[ -d "databases/$USERNAME/$dbname" ]]; then
			echo "Error --> database already exists"
			continue
		fi
		if mkdir "databases/$USERNAME/$dbname"; then
			echo "database created successfully"
			sleep 2
			dbMainMenu
			return 0
		else
			echo "failed to create database check permission"
			continue
		fi
	done
}
