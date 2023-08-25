# FCC - Salon Appointment Scheduler

![POSTGRESQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SHELL](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

## Description

This is a interactive bash programm `(salon.sh)` that keep track of clients and bookings in a database `(salon.sql)` for a salon.

This project is part of the **[freeCodeCamp](https://www.freecodecamp.org/learn/relational-database/build-a-salon-appointment-scheduler-project/build-a-salon-appointment-scheduler)** Relation Database projects certification.

## Example outputs

### Booking Example 1

<p>~~~~~~~~~~~~~~~~~~~~  Welcome to My SALON  ~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>How may I help you ?</p>
<p></p>
<p>1. Booking Menu</p>
<p>2. Cancel a Booking</p>
<p>3. Exit</p>
<p>1</p>
<p></p>
<p>~~~~~~~~~~~~~~~~~~~~~~~~  BOOKING MENU  ~~~~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>Welcome to My Salon, how can I help you?</p>
<p>1) Haircut | 20$</p>
<p>2) Color | 45$</p>
<p>3) Perm | 70$</p>
<p>4) Hairstyle | 35$</p>
<p></p>
<p>Please select a service:</p>
<p>4</p>
<p></p>
<p>You selected a Hairstyle for 35$</p>
<p>What is your phone number ?</p>
<p>123-123-12</p>
<p></p>
<p>!! Please enter valid phone number format (xxx-xxx-xxxx) !!</p>
<p>What is your phone number ?</p>
<p>123-123-1234</p>
<p></p>
<p>I don't have a record for that phone number, what's your name ?</p>
<p>75d</p>
<p></p>
<p>!! Please enter a valid name  !!</p>
<p>I don't have a record for that phone number, what's your name ?</p>
<p>Chris</p>
<p></p>
<p>Thank you Chris ! You have been added to our database.</p>
<p>What time would you like your Hairstyle, Chris?</p>
<p>11am</p>
<p></p>
<p>I have put you down for a Hairstyle at 11am, Chris.</p>
<p></p>
<p>Thank you for stopping in. We hope to see you soon !</p>

### Booking Example 2

<p>~~~~~~~~~~~~~~~~~~~~  Welcome to My SALON  ~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>How may I help you ?</p>
<p></p>
<p>1. Booking Menu</p>
<p>2. Cancel a Booking</p>
<p>3. Exit</p>
<p>1</p>
<p></p>
<p></p>
<p>~~~~~~~~~~~~~~~~~~~~~~~~  BOOKING MENU  ~~~~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>Welcome to My Salon, how can I help you?</p>
<p>1) Haircut | 20$</p>
<p>2) Color | 45$</p>
<p>3) Perm | 70$</p>
<p>4) Hairstyle | 35$</p>
<p></p>
<p>Please select a service:</p>
<p>2</p>
<p></p>
<p>You selected a Color for 45$</p>
<p>What is your phone number ?</p>
<p>123-123-1234</p>
<p></p>
<p>Welcome back  Chris !</p>
<p>What time would you like your Color, Chris?</p>
<p>17:00</p>
<p></p>
<p>I have put you down for a Color at 17:00, Chris.</p>
<p></p>
<p>Thank you for stopping in. We hope to see you soon !</p>
<p></p>

### Cancel Example 3

<p>~~~~~~~~~~~~~~~~~~~~  Welcome to My SALON  ~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>How may I help you ?</p>
<p></p>
<p>1. Booking Menu</p>
<p>2. Cancel a Booking</p>
<p>3. Exit</p>
<p>2</p>
<p></p>
<p>~~~~~~~~~~~~~~~~~~  BOOKING CANCEL MENU  ~~~~~~~~~~~~~~~~~~~~</p>
<p>What is your phone number ?</p>
<p>124</p>
<p></p>
<p>!! Please enter valid phone number format (xxx-xxx-xxxx) !!</p>
<p>What is your phone number ?</p>
<p>123-123-1234</p>
<p></p>
<p></p>
<p>~~~~~~~~~~~~~~~~~~~~~  YOUR BOOKING  ~~~~~~~~~~~~~~~~~~~~~~~~</p>
<p>65) Chris for a Hairstyle at 11am</p>
<p>66) Chris for a Color at 17:00</p>
<p></p>
<p>What booking would you like to cancel ?</p>
<p>6</p>
<p></p>
<p>!! Please enter a valid booking id. !!</p>
<p></p>
<p></p>
<p>~~~~~~~~~~~~~~~~~~~~~  YOUR BOOKING  ~~~~~~~~~~~~~~~~~~~~~~~~</p>
<p>65) Chris for a Hairstyle at 11am</p>
<p>66) Chris for a Color at 17:00</p>
<p></p>
<p>What booking would you like to cancel ?</p>
<p>66</p>
<p></p>
<p>We canceled your booking Chris !</p>
<p></p>
<p>Thank you for stopping in. We hope to see you soon !</p>
<p></p>

### Exit Example 4

<p>~~~~~~~~~~~~~~~~~~~~  Welcome to My SALON  ~~~~~~~~~~~~~~~~~~~~</p>
<p></p>
<p>How may I help you ?</p>
<p></p>
<p>1. Booking Menu</p>
<p>2. Cancel a Booking</p>
<p>3. Exit</p>
<p>3</p>
<p></p>
<p>Thank you for stopping in. We hope to see you soon !</p>
