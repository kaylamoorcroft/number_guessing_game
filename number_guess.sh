#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t -q --no-align -c"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

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

  # if not a number
  if [[ ! $GUESS_NUMBER =~ ^[0-9]+$ ]]
  then
    GUESS "That is not an integer, guess again:"
  
  # if guess is too high
  elif [[ $GUESS_NUMBER -gt $SECRET_NUMBER ]]
  then
    (( NUMBER_OF_GUESSES++ ))
    GUESS "It's lower than that, guess again:"

  # if guess is too low
  elif [[ $GUESS_NUMBER -lt $SECRET_NUMBER ]]
  then
    (( NUMBER_OF_GUESSES++ ))
    GUESS "It's higher than that, guess again:"
  
  # correct guess
  else
    (( NUMBER_OF_GUESSES++ ))
    echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi
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

# add game to database
$PSQL "INSERT INTO games(username, guesses) VALUES('$USERNAME', $NUMBER_OF_GUESSES)"