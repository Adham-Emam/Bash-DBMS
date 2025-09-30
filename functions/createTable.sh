#!/bin/bash

function createTable {
	clear
	while true; do 
		read -p "enter the name of the table you want to create or type \q to exit: " tableName
		if [[ $tableName == "\q" ]]; then
			connectDB
			return 0
		fi
		if ! validateTableName "$tableName"; then
			continue
		fi
		if [[ -f "$connectedDB/$tableName.csv" ]]; then
			echo "Error --> table already exists"
			continue
		fi
		if touch "$connectedDB/$tableName.csv"; then
			echo "table created successfully"
			sleep 2

			# column input loop
			while true; do
				read -p "Type the name of the columns you want to add separated by a space: " columnName

				header=""
				ok=true   # local temporary marker

				for column in $columnName; do
				    if validateColumnName "$column"; then
				        # Build header string (comma-separated)
				        if [ -z "$header" ]; then
				            header="$column"
				        else
				            header="$header,$column"
				        fi
				    else
				        echo "❌ Invalid column name: $column"
				        ok=false
				        break
				    fi
				done

				if $ok; then
					# Write header to CSV file
					echo "$header" > "$connectedDB/$tableName.csv"
					echo "✅ Columns added to $tableName.csv"
					sleep 2
					break   # exit column input loop
				else
					echo "⚠️ Please try again."
				fi
			done

			break   # exit outer createTable loop
		else
			echo "failed to create table check permission"
			sleep 2
			break
		fi
	done
}
