# Bash-DBMS

Bash-DBMS is a simple command-line database management system written in Bash. It provides basic functionalities for managing databases, tables, and records.

## Features

- **Database Management**: Create, rename, drop, and list databases.
- **Table Management**: Create, drop, list, and select from tables.
- **Record Management**: Insert, select, and delete records from tables.
- **Authentication**: Register a new user and login and each user have his/her own databases.

## Installation

1. Clone the repository.
2. Make sure you have Bash installed on your system.
3. Enter the project directory

```bash
    cd Bash-DBMS
```

4. run the project

```bash
    source main.sh
```

## Usage

### Authentication

- You will be asked to register a new user, or login if you already have a registered
- Then you will enter the CLI main menu
- Select the command that you want to run be typing its number

### Database Management

- To create a new database, run the `createDB` command and enter the name of the database.
- To rename a database, run the `renameDB` command and enter the current and new names of the database.
- To drop a database, run the `dropDB` command and enter the name of the database.
- To list all databases, run the `showDB` command.

### Table Management

- To create a new table in a database, run the `createTable` command and enter the name of the database and the name of the table.
- To drop a table, run the `dropTable` command and enter the name of the database and the name of the table.
- To list all tables in a database, run the `listTables` command and enter the name of the database.
- To select from a table, run the `selectFromTable` command and enter the name of the database and the name of the table.

### Record Management

- To insert a new record into a table, run the `insertIntoTable` command and enter the name of the database, the name of the table, and the values for the record.
- To select records from a table, run the `selectFromTable` command and enter the name of the database and the name of the table.
- To delete a record from a table, run the `deleteFromTable` command and enter the name of the database, the name of the table, and the row number(s) of the record(s) to delete.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with any improvements or bug fixes.
