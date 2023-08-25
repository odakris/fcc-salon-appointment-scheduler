#!/bin/bash

# Title
echo -e "\n~~~~~~~~~~~~~~~~~~~~  Welcome to My SALON  ~~~~~~~~~~~~~~~~~~~~"

# SQL requests
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi

  echo -e "\nHow may I help you ?"
  echo -e "\n1. Booking Menu\n2. Cancel a Booking\n3. Exit"
  read MAIN_MENU_SELECTION

  case $MAIN_MENU_SELECTION in
    1) BOOKING_MENU ;;
    2) BOOKING_CANCEL ;;
    3) EXIT ;;
    *) MAIN_MENU "!! Please enter a valid option. !!" ;;
  esac  
}

BOOKING_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi
  
  # menu Titles
  echo -e "\n~~~~~~~~~~~~~~~~~~~~~~~~  BOOKING MENU  ~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "\nWelcome to My Salon, how can I help you?"

  # select all services from database
  SERVICES=$($PSQL "SELECT * FROM services")

  # display services
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME BAR SERVICE_PRICE
  do
    echo "$SERVICE_ID) $SERVICE_NAME $BAR $SERVICE_PRICE$"
  done

  # ask user to select a service
  echo -e "\nPlease select a service:"
  read SERVICE_ID_SELECTED
  
  # get SERVICE_NAME selected
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ //g')

  # check if service selected exist
  if [[ -z $SERVICE_NAME ]]
  then
    # if not back to BOOKING_MENU()
    BOOKING_MENU "!! I could not find that service. What would you like today? !!"
  else
    # get SERVICE_PRICE_SELECTED
    SERVICE_PRICE_SELECTED=$($PSQL "SELECT price FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
    SERVICE_PRICE_SELECTED_FORMATTED=$(echo $SERVICE_PRICE_SELECTED | sed 's/ //g')
    
    # resume user selection
    echo -e "\nYou selected a $SERVICE_NAME_FORMATTED for $SERVICE_PRICE_SELECTED_FORMATTED$"

    # if yes then continue to GET_CUSTOMER_INFO()
    GET_CUSTOMER_INFO $SERVICE_ID_SELECTED $SERVICE_NAME_FORMATTED
  fi 
}

GET_CUSTOMER_INFO() {
  SERVICE_ID_SELECTED=$1
  SERVICE_NAME=$2

  # call GET_PHONE() and return CUSTOMER_PHONE
  GET_PHONE

  # search for customer in database with CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  # check if CUSTOMER_NAME exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # if new customer
    # call GET_NAME() and return CUSTOMER_NAME
    GET_NAME
    
    # insert new customer into database
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    
    # prompt user that he has been added into our database
    if [[ $INSERT_NEW_CUSTOMER == "INSERT 0 1" ]]
    then
      echo -e "\nThank you $CUSTOMER_NAME ! You have been added to our database."
    fi
  else
    # if cusotmer already in database
    echo -e "\nWelcome back $CUSTOMER_NAME !"
  fi

  # get CUSTOMER_ID
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  # call GET_TIME() and return SERVICE_TIME
  GET_TIME $SERVICE_NAME $CUSTOMER_NAME

  # save booking
  SAVE_BOOKING=$($PSQL "INSERT INTO appointments(time,customer_id,service_id) VALUES('$SERVICE_TIME',$CUSTOMER_ID,$SERVICE_ID_SELECTED)")

  # prompt user that his request has been saved
  if [[ $SAVE_BOOKING == "INSERT 0 1" ]]
  then
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    EXIT
  fi
}

GET_PHONE() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # ask user phone
  echo -e "What is your phone number ?"
  read CUSTOMER_PHONE

  # check if phone number is valid
  if [[ $CUSTOMER_PHONE =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]]
  then
    # if yes => return customer_phone
    CUSTOMER_PHONE="$CUSTOMER_PHONE"
  else 
    # if not => rerun ASK_PHONE() with error message
    GET_PHONE "!! Please enter valid phone number format (xxx-xxx-xxxx) !!"
  fi
}

GET_NAME() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
    # pormpt user for his name
    echo "I don't have a record for that phone number, what's your name ?"
  else
    # pormpt user for his name
    echo -e "\nI don't have a record for that phone number, what's your name ?"
  fi

  read CUSTOMER_NAME

  # check if name is valid
  if [[ $CUSTOMER_NAME =~ ^[a-zA-Z]+$ ]]
  then
    # if yes ==> return CUSTOMER_NAME
    CUSTOMER_NAME="$CUSTOMER_NAME"
  else
    # if not ==> rerun ASK_NAME() with error message
    GET_NAME "!! Please enter a valid name  !!"
  fi
}

GET_TIME() {
  if [[ -z $2 ]]
  then
    echo -e "\n$1"
  else
    SERVICE_NAME=$1
    CUSTOMER_NAME=$2 
  fi

  # prompt user for time
  echo -e "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # xx(am/pm) 
  # ^(1[0-2]|0?[1-9])([aApP][mM])$
  # On a 12-hour clock, if the first digit is 0, the second digit allows all 10 digits, 
  # but if the first digit is 1, the second digit must be 0, 1, or 2.

  # check if time format is valid
  if [[ $SERVICE_TIME =~ (^[0-9]{2}:[0-9]{2}$)|(^(1[0-2]|0?[1-9])([aApP][mM])$) ]]
  then
    # if yes ==> return SERVICE_TIME
    SERVICE_TIME="$SERVICE_TIME"
  else
    # if not ==> rerun ASK_TIME() with a error message
    GET_TIME "!! Please enter a valid time format (xx:xx or xxam or xxpm) !!"
  fi
}

BOOKING_CANCEL() {
  echo -e "\n~~~~~~~~~~~~~~~~~~  BOOKING CANCEL MENU  ~~~~~~~~~~~~~~~~~~~~"

  GET_PHONE

  # get appointments for this customer
  CUSTOMER_APPOINTMENTS=$($PSQL "SELECT appointment_id,customers.name AS customer_name,services.name AS service_name,time FROM services INNER JOIN appointments USING(service_id) INNER JOIN customers USING(customer_id) WHERE phone='$CUSTOMER_PHONE' ORDER BY appointment_id")

  # search for customer in database with CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]
  then
    # if CUSTOMER_NAME does not exist
    echo -e "\nYou do not have any booking."
    EXIT
  else
    # if CUSTOMER_NAME exist
    if [[ $CUSTOMER_APPOINTMENTS ]]
    then
      YOUR_BOOKING "$CUSTOMER_APPOINTMENTS" "$CUSTOMER_NAME" "\n~~~~~~~~~~~~~~~~~~~~~  YOUR BOOKING  ~~~~~~~~~~~~~~~~~~~~~~~~"
    else
      # if CUSTOMER_NAME does not exist
      echo -e "\nYou do not have any booking."
      EXIT
    fi
  fi 
}

YOUR_BOOKING() {
  if [[ -z $2 ]]
  then
    echo -e "\n$1"
  else
    CUSTOMER_APPOINTMENTS=$1
    CUSTOMER_NAME=$2
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ //g')
    YOUR_BOOKING_TITLE=$3
  fi

  # title
  echo -e "\n$YOUR_BOOKING_TITLE"

  # display appointments
  echo "$CUSTOMER_APPOINTMENTS" | while read APPOINTMENT_ID BAR CUSTOMER_NAME BAR SERVICE_NAME BAR SERVICE_TIME
  do
    echo "$APPOINTMENT_ID) $CUSTOMER_NAME for a $SERVICE_NAME at $SERVICE_TIME"
  done

  # ask user to select a service
  echo -e "\nWhat booking would you like to cancel ?"
  read BOOK_TO_CANCEL

  if [[ -z "$BOOK_TO_CANCEL" ]]
  then
    # if no id enter by user
    YOUR_BOOKING "!! Please enter a valid booking id. !!"
  else
    # get booking id 
    GET_BOOKING_ID=$($PSQL "SELECT appointment_id FROM services INNER JOIN appointments USING(service_id) INNER JOIN customers USING(customer_id) WHERE appointment_id=$BOOK_TO_CANCEL AND customers.name='$CUSTOMER_NAME_FORMATTED'")
    GET_BOOKING_ID_FORMATTED=$(echo $GET_BOOKING_ID | sed 's/ //g')

    # check for valid booking id
    if [[ -z $GET_BOOKING_ID ]]
    then
      # if not valid
      YOUR_BOOKING "!! Please enter a valid booking id. !!"
    else
      # if valid ==> delete booking from database
      DELETE_BOOKING=$($PSQL "DELETE FROM appointments WHERE appointment_id=$GET_BOOKING_ID")
      
      # inform user that his booking has been cancel
      if [[ $DELETE_BOOKING == "DELETE 1" ]]
      then
        echo -e "\nWe canceled your booking $CUSTOMER_NAME_FORMATTED !"
        EXIT
      fi
    fi
  fi
}

EXIT() {
  echo -e "\nThank you for stopping in. We hope to see you soon !\n"
}

MAIN_MENU