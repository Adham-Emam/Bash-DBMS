#!/bin/bash
echo "Welcome to Bash-DBMS"

# Check if databases directory exists
if [ ! -d "databases" ]; then
    mkdir databases
fi



while true; do
    echo
    echo "1. Login"
    echo "2. Register"
    echo "3. Exit"
    read -p "Enter your choice: " choice    

    case $choice in
        1)
            while true; do
                read -p "Enter username: " username
                read -s -p "Enter password: " password
                echo 

                # Hash the password
                login_hash=$(printf "%s" "$password" | sha256sum | awk '{print $1}')

                # Check if the username and password match
                if grep -q "$username:$login_hash$" ./users.csv; then
                    echo "Login successful"
                    break 2

                else
                    echo "Invalid username or password"
                fi
            done
            ;;
        2)
            while true; do
                read -p "Enter username: " username

                # Validate the username
                if [[ ! $username =~ ^[a-zA-Z0-9_]{3,15}$ ]]; then
                    echo "Username must be 3–15 characters (letters, numbers, underscores only)."
                    continue
                fi

                # Check if the username already exists
                if grep -q "^$username:" ./users.csv; then
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
                    echo "Passwords do not match. Try again."
                    continue
                fi

                if [[ ${#password} -lt 8 ]] && [[ ! $password =~ [A-Za-z] ]] && [[ ! $password =~ [0-9] ]]; then
                    echo "Password must be at least 8 characters and contain at least one letter and one number."
                    continue
                fi

                # break the loop if the passwords match
                break
            done

            # Hash the password
            pass_hash=$(printf "%s" "$password" | sha256sum | awk '{print $1}')

            # Store the username and password
            echo "$username:$pass_hash" >> ./users.csv
            echo "Registration successful"
            ;;
        3)
            exit
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
done




# echo "1. Create Database"
# echo "2. List Database"
# echo "3. Connect to Database"
# echo "4. Drop Database"
# echo "5. Exit"

# read -p "Enter your choice: " choice

# case $choice in
#     1)
#         read -p "Enter new database name: " dbname
#         mkdir $dbname
#         echo "Database $dbname created successfully"
#         ;;
#     2)
#         ls ./databases
#         ;;
#     3)
#         read -p "Enter database name to connect: " dbname
#         cd $dbname
#         ;;
#     4)
#         read -p "Enter database name to delete: " dbname
#         rm -r $dbname
#         echo "Database $dbname deleted successfully"
#         ;;
#     5)
#         exit
#         ;;
#     *)
#         echo "Invalid choice"
#         ;;
# esac


