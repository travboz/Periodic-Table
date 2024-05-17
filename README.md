# Football World Cup Database created using PostgreSQL
This repository contains the code used to create a Relaitional Database that focuses on the topic of World Cup Football data. This is a PostgreSQL database.

**INFORMATION BELOW IS PLACEHOLDER for formatting and structure**

## Dependencies
- [PostgreSQL](https://www.postgresql.org/download/)

## Installation
- Clone this repo: 
`git clone https://github.com/travboz/World-Cup-SQL-DB.git`.

- Navigate into your project directory: 
`cd your_project_folder/World-Cup-SQL-DB` (for example).

The commands used to build the database are contained in the `worldcup.sql` file. 

- Building the database
When in the folder containing the `worldcup.sql` file, run the following command to create and populate the database:
`psql -U postgres < worldcup.sql`

Using a program like [pgAdmin](https://www.pgadmin.org/download/) you can inspect the architecture of the database. Alternatively, you can use SQL queries to explore.

There exist five tables with each table containing related information pertaining to stars, planets, galaxies, spacecraft, and moons.

| Table Name  | Description                                                                                                           |
|-------------|-----------------------------------------------------------------------------------------------------------------------|
| `teams`     | Stores team_id and team name information. |
| `games`     | Contains data pertaining to specific games played by two teams, a winner and their opponent. It is also contains year, round title, and scores for each team. |


This project was created to follow the FreeCodeCamp certification project.

Project link: [Worldcup Database](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database)
