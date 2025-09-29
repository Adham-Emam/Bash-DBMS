#!/bin/bash

function createTable {
	clear
	echo "==============================================================================================================================================="
	echo ""
	echo "                                                              create Table in $dbname "
	echo ""
	echo "==============================================================================================================================================="
	while true; do
		read -p " enter table name or type exit : " tablename
		if [[ $tablename == "exit" ]]; then
			TablesMainMenu
			return
		fi
		if ! validateTableName "$tablename"; then
			continue
		fi
		TABLE_PATH= "$DB_ROOT/$USERNAME/$dbname/$tablename.csv"
		META_PATH="$DB_ROOT/$USERNAME/$dbname/${tablename}_meta.csv"
		if [[ -f "$TABLE_PATH" ]]; then
			echo "ERROR--table already exists!!"
			continue
		fi
		read -p "please enter  the number of columns" col_Num

		if ! [[ "$col_Num" =~ ^[1-9][0-9]*$ ]]; then
			echo "ERROR--column number must be a postive integar!!"
			return
		fi
		local -a col_Names=()
		local -a col_Types=()
		local -a col_PKS=()
		local -a col_Uniques=()
		local -a col_Nullables=()
		local primary_Key_Count=0
		for (( j=1; j<=col_Num; j++)); do
			while true; do
				read -rp "Column #$j name: " col_Name
				if ! validateColumnName "$col_Name"; then
					continue
				fi
				# checking for duplicates
				local is_Duplicate= false
				for n in "{$col_Names[@]}"; do
					if [[ "$n" == "$col_Name" ]]; then
						is_Duplicate=true
						break
					fi

				done
				if is_Duplicate; then
					echo "Column name : $col_Name is already in use"
					continue
				fi
				break
			done
			# checktype
			local col_type
			while true; do
				read -rp "Column #$j type [string|int]: " col_type
				col_type= "{$col_type,,}"
				if [[ "$col_type" != "string" && "$col_type" != "int" ]]; then
					echo "Invalid type; choose 'string' or 'int'."
					continue
				fi
				break
			done
			# checking for primary
			read -rp "Is this the Primary Key? (y/N): " ans_pk
			local is_pk=false
			if [[ "${ans_pk,,}" == "y" || "${ans_pk,,}" == "yes" ]]; then
				is_pk=true
				((primary_Key_Count++))
			fi
			# unique
			read -rp "Should this column be unique? (y/N): " ans_unique
			local is_unique=false
			if [[ "${ans_unique,,}" == "y" || "${ans_unique,,}" == "yes" ]]; then
				is_unique=true
			fi
			# nullable
			read -rp "Can this column be NULL? (y/N): " ans_nullable
			local is_nullable=false
			if [[ "${ans_nullable,,}" == "y" || "${ans_nullable,,}" == "yes" ]]; then
				is_nullable=true
			fi
			# store
			col_Names+=("$col_Name")
			col_Types+=("$col_type")
			col_PKS+=("$is_pk")
			col_Uniques+=("$is_unique")
			col_Nullables+=("$is_nullable")
		done
		if [[ "$primary_Key_Count" -eq 0 ]]; then
			echo "Error--no primary key defined! You must insert at least one pk."
			continue
		fi
		(
		IFS=','; echo "${col_Names[*]}"
		) > "$TABLE_PATH" || { echo "Failed to write $TABLE_PATH"; rm -f "$TABLE_PATH" "$META_PATH"; continue; }
		# meta csv
		{
			echo "Name,Type,PrimaryKey,Unique,Nullable"
			for i in "${!col_Names[@]}"; do
				printf '%s,%s,%s,%s,%s\n' \
					"${col_Names[i]}" "${col_Types[i]}" "${col_PKS[i]}" "${col_Uniques[i]}" "${col_Nullables[i]}"
			done
		} > "$META_PATH" || { echo "Failed to write $META_PATH"; rm -f "$TABLE_PATH" "$META_PATH"; continue; }
		echo "Table '$tablename' created successfully!"
		echo "Data file: $TABLE_PATH"
		echo "Meta file: $META_PATH"
		while true; do
			echo "What do you want to do next?"
			echo "1) Return to Main Menu"
			echo "2) Add Another Table"
			read -rp "Choose [1-2]: " choice
			case "$choice" in
				1)
					TablesMainMenu
					return 0
					;;
				2)
					break
					;;
				*)
					echo "enter a valid choice please"
					;;
			esac
		done
	done
}
