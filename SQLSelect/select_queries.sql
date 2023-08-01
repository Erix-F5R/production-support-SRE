use PersonalTrainer;

#Activity 1

select * from Exercise;

#Activity 2

select * from Client;

#Activity 3

Select * from Client Where City = 'Metairie;

#Activity 4

Select * from Client where ClientId = '818u7faf-7b4b-48a2-bf12-7a26c92de20c' ;

#Activity 5

Select * from Goal;

#Activity 6

Select Name, LevelId from Workout;

#Activity 7

Select Name, LevelId, Notes from Workout where LevelId = 2;

#Activity 8
Select FirstName, LastName, City from Client where City IN ('Metairie', 'Kenner', 'Gretna');

#Activity 9
Select FirstName, LastName, BirthDate from Client WHERE BirthDate BETWEEN '1980-01-01' AND '1989-12-31';

#Activity 10
Select FirstName, LastName, BirthDate from Client WHERE BirthDate >= '1980-01-01' AND BirthDate < '1990-01-01';

#Acvitity 11
SELECT * FROM Login WHERE EmailAddress LIKE '%.gov'

#Activity 12
SELECT * FROM Login WHERE EmailAddress NOT LIKE '%.com'


#Activity 13
SELECT FirstName, LastName FROM Client WHERE Birthdate IS NULL;

#Activity 14
SELECT * FROM Client WHERE BirthDate Is NULL;

#Activity 15
SELECT Name, Notes FROM Workout WHERE LevelId = '3' AND Notes LIKE '%you%';

#Activity 16
SELECT FirstName, LastName, City
FROM Client
WHERE City = 'LaPlace'
AND (
 LastName LIKE 'L%' OR LastName LIKE 'M%' OR LastName LIKE 'N%');

#Activity 17
SELECT InvoiceId, Description, Price, Quantity, ServiceDate, ( Price*Quantity ) AS line_item_total
FROM InvoiceLineItem
WHERE Price * Quantity >= 15
AND Price * Quantity <= 25 ;

#Activity 18
SELECT * FROM Login Where ClientID = (SELECT ClientID FROM Client WHERE FirstName = 'Estrella' AND LastName = 'Bazely');

#Activity 19

SELECT Name FROM Goal Where GoalId = 3 OR GoalID = 8 Or GoalID = 15;

SELECT GoalID FROM WorkoutGoal WHERE WorkoutId = (

	SELECT WorkoutId FROM Workout WHERE Name = 'This Is Parkour'
);

