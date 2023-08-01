USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
--------------------

SELECT 
	*
FROM
    Exercise
INNER JOIN
    ExerciseCategory
ON
    Exercise.ExerciseCategoryId = ExerciseCategory.ExerciseCategoryId; 
        


    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
--------------------


SELECT 
	ExerciseCategory.Name,
    Exercise.Name
FROM
    Exercise
INNER JOIN
    ExerciseCategory
ON
    Exercise.ExerciseCategoryId = ExerciseCategory.ExerciseCategoryId
WHERE ExerciseCategory.ParentCategoryId IS NULl;
        

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
--------------------

SELECT 
	ExerciseCategory.Name AS CategoryName,
    Exercise.Name AS ExerciseName
FROM
    Exercise
INNER JOIN
    ExerciseCategory
ON
    Exercise.ExerciseCategoryId = ExerciseCategory.ExerciseCategoryId
WHERE ExerciseCategory.ParentCategoryId IS NULl;


-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
--------------------
SELECT 
    Client.FirstName,
    Client.LastName,
    Client.BirthDate,
    Login.EmailAddress
FROM
    Client
        INNER JOIN
    Login ON Client.ClientId = Login.ClientId
WHERE
    Client.BirthDate BETWEEN '1990-01-01' AND '1999-12-31';

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
--------------------

SELECT 
    Workout.Name, Client.FirstName, Client.LastName
FROM
    Client
        INNER JOIN
    ClientWorkout ON Client.ClientId = ClientWorkout.ClientId
        INNER JOIN
    Workout ON Workout.WorkoutId = ClientWorkout.WorkoutId
WHERE
    Client.LastName LIKE 'C%'

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
--------------------
SELECT 
    Workout.Name AS WorkoutName, Goal.Name AS GoalName
FROM
    Workout
        INNER JOIN
    WorkoutGoal ON Workout.WorkoutId = WorkoutGoal.WorkoutId
        INNER JOIN
    Goal ON WorkoutGoal.GoalId = Goal.GoalId;

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
--------------------


-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
--------------------
SELECT 
    FirstName,
    LastName,
    Login.ClientId,
    Login.EmailAddress
FROM
    Client
        LEFT OUTER JOIN
    Login ON Client.ClientId = Login.ClientId
WHERE Login.ClientId IS NULL;

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
--------------------
SELECT 
	*
FROM
    Client
        LEFT OUTER JOIN
    Login ON Client.ClientId = Login.ClientID
WHERE Client.FirstName = 'Romeo' AND Client.LastName = 'Seaward'
AND Login.ClientId IS NOT NULL;

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
--------------------
SELECT 
    parent.Name AS CategoryName, child.Name AS ExerciseName
FROM
    ExerciseCategory parent
INNER JOIN ExerciseCategory child ON parent.ExerciseCategoryId = child.ParentCategoryId;
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
--------------------
SELECT 
    parent.Name AS CategoryName,
    child.Name AS ExerciseName
FROM
    ExerciseCategory parent
RIGHT JOIN ExerciseCategory child ON parent.ExerciseCategoryId = child.ParentCategoryId;
    
-- Are there Clients who are not signed up for a Workout?
-- 50 rows
--------------------
SELECT 
    *
FROM
    Client
        LEFT OUTER JOIN
	ClientWorkout
    ON ClientWorkout.ClientId = Client.ClientId
WHERE ClientWorkout.ClientID IS NULL;

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
--------------------
SELECT 
    Workout.*
FROM
    Workout
        INNER JOIN
    Level ON Workout.LevelId = Level.LevelId
        INNER JOIN
    WorkoutGoal ON Workout.WorkoutId = WorkoutGoal.WorkoutId
        INNER JOIN
    Goal ON WorkoutGoal.GoalId = Goal.GoalId
        INNER JOIN
    ClientGoal ON Goal.GoalId = ClientGoal.GoalId
        INNER JOIN
    Client ON ClientGoal.ClientID = Client.ClientId
WHERE
    Client.FirstName = 'Shell'
        AND Client.LastName = 'Creane'
        AND Level.Name = 'Beginner';

-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals
--------------------
SELECT 
    *
FROM
    Workout
LEFT OUTER JOIN WorkoutGoal ON Workout.WorkoutId = WorkoutGoal.WorkoutId
LEFT OUTER JOIN Goal on WorkoutGoal.GoalId = Goal.GoalId
WHERE Goal.Name = 'Core Strength'
OR Goal.Name IS NULL;

;

-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
--------------------
SELECT Workout.Name, Exercise.Name
FROM Workout
INNER JOIN WorkoutDay ON Workout.WorkoutId = WorkoutDay.WorkoutId
INNER JOIN WorkoutDayExerciseInstance ON WorkoutDay.WorkoutDayId = WorkoutDayExerciseInstance.WorkoutDayId
INNER JOIN ExerciseInstance ON WorkoutDayExerciseInstance.ExerciseInstanceId = ExerciseInstance.ExerciseInstanceId
INNER JOIN Exercise ON ExerciseInstance.ExerciseId = Exercise.ExerciseId

;
   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values
--------------------

SELECT Exercise.Name, ExerciseInstanceUnitValue.Value, Unit.Name
FROM Exercise
INNER JOIN ExerciseInstance ON Exercise.ExerciseId = ExerciseInstance.ExerciseId
INNER JOIN ExerciseInstanceUnitValue ON ExerciseInstance.ExerciseInstanceId = ExerciseInstanceUnitValue.ExerciseInstanceId
INNER JOIN Unit ON ExerciseInstanceUnitValue.UnitId = Unit.UnitId
WHERE Exercise.Name = 'Plank'

;
