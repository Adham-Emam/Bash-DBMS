#!/bin/bash
function createDB {
	clear
	while true; do
		read -p "enter the name of the database you want to create or type exit" dbname
		if [[ $dbname == "exit" ]]; then
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
			echo "Error--database already exists"
			continue
		fi
		if mkdir "databases/$USERNAME/$dbname"; then
			echo "database created successfully"
			return 0
		else
			echo "failed to create database check premission"
			continue
		fi
	done
}
