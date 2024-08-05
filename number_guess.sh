#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t -q --no-align -c"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

GUESS() {
  # print message
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nGuess the secret number between 1 and 1000:"
  fi
  # get guess
  read GUESS_NUMBER
}

echo "Enter your username:"
read USERNAME

EXISTING_USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

# if username has not been used before
if [[ -z $EXISTING_USERNAME ]]
then
  # print welcome message
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # add username to database
  $PSQL "INSERT INTO users(username) VALUES('$USERNAME')"
fi

GUESS