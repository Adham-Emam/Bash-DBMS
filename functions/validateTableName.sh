#!/bin/bash
function validateTableName {
	local tablename=$1
	if [[ -z $tablename ]]; then
		echo "ERROR-- table name cannot be empty"
		return 1
	fi
	if [[ "$tablename" == *" "* ]]; then
		echo "ERROR--Table name cannot contain spaces"
		return 1
	fi
	if [[ "$table" =~ [^a-zA-Z0-9_] ]]; then
		echo "ERROR--Table name cannot contain special characters other than underscore"
		return 1
	fi
	if [[ "$tablename" =~ ^[0-9] ]]; then 
		echo "ERROR--Table name cannot start with a number"
		return 1
	fi
	return 0
}
