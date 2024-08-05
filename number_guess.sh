#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t -q --no-align -c"

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