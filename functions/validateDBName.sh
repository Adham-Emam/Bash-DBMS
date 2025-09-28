#!/bin/bash
function validateDBName {
	local dbname="$1"
	if [[ -z $dbname ]]; then
		echo "Error--Database name cannot be empty."
		return 1
	fi
	if [[ $dbname == *" "* ]]; then
		echo "Error----database name cannot contain spaces"
		return 1
	fi
	if [[ $dbname =~ [^a-zA-Z0-9_] ]]; then
		echo "Error-- database cannot contain special characters other than  underscore"
		return 1
	fi
	if [[ $dbname =~ ^[0-9] ]]; then 
		echo "Error-- database cannot begin with a number"
		return 1
	fi
	return 0
}
