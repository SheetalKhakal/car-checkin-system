Car Check-in and Check-out System

Overview

This project is a simple car check-in and check-out system built using Flutter. It stores car data (car number, check-in time, and check-out time) 

in a local database (using sqflite for this implementation) and provides a basic UI for managing car check-ins and check-outs. The app features 

validation to ensure a car can only be checked in once until checked out, and displays a list of cars that are checked in but not checked out yet.

Requirements

1.	Flutter: The project is built using Flutter. You can install Flutter from here.

2.	sqflite: A local SQLite database to store car check-in and check-out data.

Features
•	Check-in Flow: Allows the user to enter a car number and check it in. The car's information is stored in the local database, and the app 

ensures that the car cannot be checked in again until it is checked out.

•	Display Cars Not Checked Out: Displays a list of all cars that are checked in but not yet checked out. Each car shows its number and check-in 

time.

•	Check-out Flow: Adds an option to check out cars. When a car is checked out, the check-out time is stored in the database.

•	Basic UI: The UI is simple, focusing on functionality and ease of use.

•	Bonus Features: Sorting and filtering of the cars by check-in time and validation for empty input fields or invalid car numbers.

Dependencies

•	sqflite: Local SQLite database for storing data.

•	flutter: For UI development.

Database Setup

The app uses sqflite for local database management. The DatabaseHelper class is responsible for:

•	Creating the cars table with the following columns:

o	carNumber (Primary Key, String, unique)

o	checkInTime (DateTime)

o	checkOutTime (nullable DateTime)

•	Fetching, inserting, and updating car data.

UI Design

1. Check-in Screen:

•	Allows the user to input the car number.

•	The car can only be checked in if it hasn't been checked in already.

2. Cars List Screen:

•	Displays a list of cars that have been checked in but not checked out.

•	Each item includes the car number and the check-in time.

•	There is a button next to each car to check it out, which updates the check-out time in the database.

Validation

•	Car Number: Ensures the input car number is valid (not empty and unique).

•	Empty Input: Handles cases where the user tries to check in with an empty car number.

Bonus Features

•	Sorting: The car list can be sorted by check-in time, either in ascending or descending order.




 
