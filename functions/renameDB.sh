#!/bin/bash

function renameDB {
    clear
    if [[ ! -d $DB_ROOT/$USERNAME ]]; then
        echo "No databases found, please create one first."
    else 
        cd $DB_ROOT/$USERNAME
        echo "Available databases:"
        ls -d */ | sed 's:/$::'


        while true; do
            read -p "enter the name of the database you want to rename: " dbName
            if [[ -d $dbName ]]; then
                break
            else 
                echo "database not found."
                continue
            fi
        done 

        while true; do
            read -p "enter the new name of the database: " newName

            validateDBName $newName
            if [[ $? -eq 0 ]]; then
                break
            fi
        done

        mv "$dbName" "$newName"
        cd ../..
        clear
        echo "database renamed successfully"
    fi
}
