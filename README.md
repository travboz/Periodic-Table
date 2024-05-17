# Periodic Table Database created using PostgreSQL and Bash
This repository contains the code used to create a Relaitional Database that holds periodic table of elements data. There is a small Bash script used to query/search for a specific element within the table.

## Dependencies
- [PostgreSQL](https://www.postgresql.org/download/)
- [Bash](https://www.gnu.org/software/bash/)

## Installation
- Clone this repo: 
`git clone https://github.com/travboz/Periodic-Table.git`.

- Navigate into your project directory: 
`cd your_project_folder/Periodic-Table` (for example).

The commands used to build the database are contained in the `periodic_table.sql` file. 

- Building the database
When in the folder containing the `periodic_table.sql` file, run the following command to create and populate the database:
`psql -U postgres < periodic_table.sql`

- Querying the database
Run the `element.sh` shell script. Run it as follows:
`element.sh < atomic_number | symbol | element_name >` where:
- `atomic_number` would be the atomic number of an element, e.g. `1` for Hydrogen.
- `symbol` is the element symbol, e.g. 'Ne' for Neon.
- `element_name` as a capitalised string of the element's name, e.g. Boron.

Using a program like [pgAdmin](https://www.pgadmin.org/download/) you can inspect the architecture of the database. Alternatively, you can use SQL queries to explore.

There exist three tables with each table containing related information pertaining to elements, their properties, and types of element.

| Table Name  | Description                                                                                                           |
|-------------|-----------------------------------------------------------------------------------------------------------------------|
| `elements`     | General identification data for the element. |
| `properties`     | Various properties describing the element. |
| `types`     | Contains an id and type for an element. |


This project was created to follow the FreeCodeCamp certification project.

Project link: [Periodic Table](https://www.freecodecamp.org/learn/relational-database/build-a-periodic-table-database-project/build-a-periodic-table-database)
