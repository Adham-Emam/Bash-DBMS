#!/bin/bash
function validateColumnName {
	local column_Name="$1"
	if [[ -z "$column_Name" ]]; then
		echo "ERROR --> column name cannot be empty"
		return 1
	fi
	if [[ "$column_Name" == *" "* ]]; then
		echo "ERROR --> Column name cannot contain spaces"
		return 1
	fi
	if [[ "$column_Name" =~ [^a-zA-Z0-9_] ]]; then
		echo "ERROR --> Column name cannot contain special characters other than underscore"
		return 0
	fi
	if [[ "$column_Name" =~ ^[0-9] ]]; then 
		echo "ERROR --> column name cannot start with a number"
		return 0
	fi
}
