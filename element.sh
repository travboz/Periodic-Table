PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

FETCH_DATA() { 
  # $1 holds symbol
  # $2 holds the condition type (by symbol, by atomic number, by name)

  CONDITION=""
  if [[ "$2" == 'symbol' ]]
  then
    CONDITION="WHERE elements.symbol = '$1'"
  fi

  if [[ "$2" == 'atomic_number' ]]
  then
    CONDITION="WHERE elements.atomic_number = $1"
  fi

  if [[ "$2" == 'name' ]]
  then 
    CONDITION="WHERE elements.name = '$1'"
  fi

  FETCH_QUERY="
    SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius 
    FROM elements 
    FULL JOIN properties ON elements.atomic_number = properties.atomic_number 
    LEFT JOIN types ON  properties.type_id = types.type_id
    $CONDITION
    ORDER BY elements.atomic_number;
  "
  FETCH_QUERY_RESULT=$($PSQL "$FETCH_QUERY")
  echo "$FETCH_QUERY_RESULT"
}

### CLI app
if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument."
  exit
else
  # if input arg is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # searching by atomic_number
    FETCHED_DATA=$(FETCH_DATA $1 "atomic_number")
  else
    if [[ $1 = [A-Z] || $1 = [A-Z][a-z] ]]
    then
      # search by symbol
      FETCHED_DATA=$(FETCH_DATA $1 "symbol")
    else
      # search by element name
      FETCHED_DATA=$(FETCH_DATA $1 "name")
    fi
  fi
  # if the element existed in our database
  if [[ ! -z $FETCHED_DATA ]] 
  then
    echo "$FETCHED_DATA" | while read A_NUM BAR A_NAME BAR A_SYM BAR A_TYPE BAR A_MASS BAR A_MELT BAR A_BOIL BAR
    do
      echo "The element with atomic number $A_NUM is $A_NAME ($A_SYM). It's a $A_TYPE, with a mass of $A_MASS amu. $A_NAME has a melting point of $A_MELT celsius and a boiling point of $A_BOIL celsius."
    done
  # the element didn't exist
  else
    echo "I could not find that element in the database."
  fi
fi
