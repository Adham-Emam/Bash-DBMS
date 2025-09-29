#!/bin/bash

function auth {
    while true; do
        echo
        echo "1. Login"
        echo "2. Register"
        echo "3. Exit"
        read -p "Enter your choice: " choice    
        clear

        case $choice in
            1)
                while true; do
                    read -p "Enter username: " username
                    read -s -p "Enter password: " password
                    echo 

                    # Hash the password
                    login_hash=$(printf "%s" "$password" | sha256sum | awk '{print $1}')

                    # Check if the username and password match
                    if grep -q "$username:$login_hash$" $DB_ROOT/users.csv; then
                        clear
                        echo "Welcome Back, $username!"
                        export USERNAME=$username
                        break 2

                    else
                        clear
                        echo "Invalid username or password"
                    fi
                done
                ;;
            2)
                while true; do
                    read -p "Enter username: " username

                    # Validate the username
                    if [[ ! $username =~ ^[a-zA-Z0-9_]{3,15}$ ]]; then
                        clear
                        echo "Username must be 3–15 characters (letters, numbers, underscores only)."
                        continue
                    fi

                    # Check if the username already exists
                    if grep -q "^$username:" $DB_ROOT/users.csv; then
                        clear
                        echo "Username already exists. Try another."
                        continue
                    fi

                    # break the loop if the username is valid
                    break
                done

                while true; do
                    read -s -p "Enter password: " password
                    echo
                    read -s -p "Confirm password: " confirm_password


                    # Check if the passwords match
                    if [[ "$password" != "$confirm_password" ]]; then 
                        clear
                        echo "Passwords do not match. Try again."
                        continue
                    fi

                    if [[ ${#password} -lt 8 ]] && [[ ! $password =~ [A-Za-z] ]] && [[ ! $password =~ [0-9] ]]; then
                        clear
                        echo "Password must be at least 8 characters and contain at least one letter and one number."
                        continue
                    fi

                    # break the loop if the passwords match
                    break
                done

                # Hash the password
                pass_hash=$(printf "%s" "$password" | sha256sum | awk '{print $1}')

                # Store the username and password
                echo "$username:$pass_hash" >> $DB_ROOT/users.csv
                clear
                echo "Registration successful"
                ;;
            3)
                clear
                exit
                ;;
            *)
                clear
                echo "Invalid choice"
                ;;
        esac
    done
}