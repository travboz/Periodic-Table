## PSQL manipulation

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# renaming some fields
RENAME_TO_ATOMIC_MASS_QUERY="ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;"
RENAME_TO_ATOMIC_MASS=$($PSQL "$RENAME_TO_ATOMIC_MASS_QUERY")

RENAME_MELTING_POINT_QUERY="ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;"
RENAME_MELTING_POINT=$($PSQL "$RENAME_MELTING_POINT_QUERY")

RENAME_BOILING_POINT_QUERY="ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;"
RENAME_BOILING_POINT=$($PSQL "$RENAME_BOILING_POINT_QUERY")

# setting some constraints
# setting melting and boiling points to NOT NULL
NOT_NULL_MELTING_POINT_QUERY="ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;"
NOT_NULL_BOILING_POINT_QUERY="ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;"

# results after calling queries
NOT_NULL_MELTING_POINT=$($PSQL "$NOT_NULL_MELTING_POINT_QUERY")
NOT_NULL_BOILING_POINT=$($PSQL "$NOT_NULL_BOILING_POINT_QUERY")

# setting symbol and name to UNIQUE
SET_SYMBOL_AND_NAME_TO_UNIQUE_QUERY="ALTER TABLE elements ADD CONSTRAINT symbol_unique UNIQUE (symbol),
ADD CONSTRAINT name_unique UNIQUE (name);"
SET_SYMBOL_AND_NAME_TO_UNIQUE=$($PSQL "$SET_SYMBOL_AND_NAME_TO_UNIQUE_QUERY")
# setting symbol and name to NOT NULL
SYMBOL_NOT_NULL_QUERY="ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;"
NAME_NOT_NULL_QUERY="ALTER TABLE elements ALTER COLUMN name SET NOT NULL;"
SYMBOL_NOT_NULL=$($PSQL "$SYMBOL_NOT_NULL_QUERY")
NAME_NOT_NULL=$($PSQL "$NAME_NOT_NULL_QUERY")

# setting atomic_number to foreign key
ATOMIC_FK_QUERY="ALTER TABLE properties ADD CONSTRAINT atomic_number_fk_proprties FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);"
ATOMIC_FK=$($PSQL "$ATOMIC_FK_QUERY")

# creating types table
CREATE_TYPES_TABLE_QUERY="CREATE TABLE types (
    type_id SERIAL PRIMARY KEY,
    type VARCHAR(30) NOT NULL
);"
CREATE_TYPES_TABLE=$($PSQL "$CREATE_TYPES_TABLE_QUERY")

INSERT_TYPES_QUERY="INSERT INTO types(type) VALUES ('metal'), ('nonmetal'), ('metalloid');"
INSERT_TYPES=$($PSQL "$INSERT_TYPES_QUERY")

# adding type_id to properties
PROPERTIES_TYPE_FK_QUERY="ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);"
PROPERTIES_TYPE_FK=$($PSQL "$PROPERTIES_TYPE_FK_QUERY")

# updating before making NOT NULL
UPDATE_TYPE_IDS_QUERY="UPDATE properties
SET type_id = (SELECT type_id FROM types WHERE types.type=properties.type);"
UPDATE_TYPE_IDS=$($PSQL "$UPDATE_TYPE_IDS_QUERY")

# setting to NOT NULL
TYPES_NOT_NULL_QUERY="ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;"
TYPES_NOT_NULL=$($PSQL "$TYPES_NOT_NULL_QUERY")

# capitalise first letter of symbol
CAPITALISE_FIRST_LETTER_QUERY="UPDATE elements SET symbol = INITCAP(symbol) RETURNING *;"
CAPITALISE_FIRST_LETTER=$($PSQL "$CAPITALISE_FIRST_LETTER_QUERY")

# removing trailing zeros
REMOVE_TRAILING_QUERY="ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::TEXT)::DECIMAL;"
REMOVE_TRAILING=$($PSQL "$REMOVE_TRAILING_QUERY")

# remove type column in properties
REMOVE_TYPE_COLUMN_QUERY="ALTER TABLE properties DROP COLUMN type;"
REMOVE_TYPE_COLUMN=$($PSQL "$REMOVE_TYPE_COLUMN_QUERY")


# inserting Fluorine and Neon - Transactions
INSERT_FLUORINE_TRANSACTION="
BEGIN;

INSERT INTO elements (atomic_number, symbol, name)
VALUES (9, 'F', 'Fluorine');

INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (
    (SELECT atomic_number FROM elements WHERE name = 'Fluorine'),
    18.998,
    -220,
    -188.1,
    (SELECT type_id FROM types WHERE type = 'nonmetal')
);

COMMIT;
"
INSERT_FLUORINE=$($PSQL "$INSERT_FLUORINE_TRANSACTION")

INSERT_NEON_TRANSACTION="
BEGIN;

INSERT INTO elements (atomic_number, symbol, name)
VALUES (10, 'Ne', 'Neon');

INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (
    (SELECT atomic_number FROM elements WHERE name = 'Neon'),
    20.18,
    -248.6,
    -246.1,
    (SELECT type_id FROM types WHERE type = 'nonmetal')
);

COMMIT;"
INSERT_NEON=$($PSQL "$INSERT_NEON_TRANSACTION")

# removing element with atomic_number == 1000
REMOVE_1000_ELEMENTS_QUERY="DELETE FROM elements WHERE atomic_number = 1000;"
REMOVE_1000_PROPERTIES_QUERY="DELETE FROM properties WHERE atomic_number = 1000;"

REMOVE_1000_PROPERTIES=$($PSQL "$REMOVE_1000_PROPERTIES_QUERY")
REMOVE_1000_ELEMENTS=$($PSQL "$REMOVE_1000_ELEMENTS_QUERY")

