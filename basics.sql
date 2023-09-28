---1. Create Database
---You now know how to create databases using the GUI of the SSMS. Now it's time to create it using SQL queries.
---In that task (and the several following it) you will be required to create the database
---from the previous exercise using only SQL queries. First, just create new database named Minions.


CREATE DATABASE Minions;

--===============================================================================================================--

---2. Create Tables
---In the newly created database Minions add table Minions (Id, Name, Age).
---Then add a new table Towns (Id, Name). Set Id columns of both tables to be primary key as constraint


USE Minions; -- Specify the database

CREATE TABLE Minions (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT
);

-- Create the Towns table
CREATE TABLE Towns (
    Id INT PRIMARY KEY,
    Name VARCHAR(255)
);


--===============================================================================================================--

---3. Alter Minions Table

---Change the structure of the Minions table to have a new column
---TownId that would be of the same type as the Id column in Towns table.
---Add a new constraint that makes TownId foreign key and references to Id column in Towns table.

ALTER TABLE Minions
ADD TownId INT;

-- Create a foreign key constraint on the TownId column
ALTER TABLE Minions
ADD CONSTRAINT FK_TownId FOREIGN KEY (TownId) REFERENCES Towns(Id);

--===============================================================================================================--

---4. Insert Records in Both Tables

---Populate both tables with sample records, given in the table below.

---Minions Towns

---Id Name Age TownId Id Name

---1 Kevin 22 1 1 Sofia

---2 Bob 15 3 2 Plovdiv

---3 Steward NULL 2 3 Varna

---Use only SQL queries. Insert the Id manually (don't use identity)

INSERT INTO Towns (Id, Name)
VALUES
    (1, 'Sofia'),
    (2, 'Plovdiv'),
    (3, 'Varna');

-- Insert records into the Minions table
INSERT INTO Minions (Id, Name, Age, TownId)
VALUES
    (1, 'Kevin', 22, 1),
    (2, 'Bob', 15, 3),
    (3, 'Steward', NULL, 2);


--===============================================================================================================--

---5. Truncate Table Minions

---Delete all the data from the Minions table using SQL query.

TRUNCATE TABLE Minions;

--===============================================================================================================--

---6. Drop All Tables

---Delete all tables from the Minions database using SQL query.

DROP TABLE Minions;
DROP TABLE Towns;

--===============================================================================================================--
---7. Create Table People

---Using SQL query, create table People with the following columns:

---· Id – unique number. For every person there will be no more than 231-1 people (auto incremented).
---· Name – full name of the person. There will be no more than 200 Unicode characters (not null).
---· Picture – image with size up to 2 MB (allow nulls).
---· Height – in meters. Real number precise up to 2 digits after floating point (allow nulls).
---· Weight – in kilograms. Real number precise up to 2 digits after floating point (allow nulls).
---· Gender – possible states are m or f (not null).
---· Birthdate – (not null).
---· Biography – detailed biography of the person. It can contain max allowed Unicode characters (allow nulls).

---Make the Id a primary key. Populate the table with only 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.

CREATE TABLE People (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Picture VARBINARY(MAX),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('m', 'f')),
    Birthdate DATE NOT NULL,
    Biography NVARCHAR(MAX)
);

-- INSERT 5 records into the Persons table
INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
    ('John Doe', NULL, 1.75, 75.5, 'm', '1990-05-15', 'John Doe is a fictional character.'),
    ('Jane Smith', NULL, 1.65, 55.0, 'f', '1985-03-20', 'Jane Smith is an actress.'),
    ('Bob Johnson', NULL, 1.80, 85.0, 'm', '1982-12-10', 'Bob Johnson is a software engineer.'),
    ('Alice Brown', NULL, 1.60, 60.0, 'f', '1992-08-25', 'Alice Brown is a teacher.'),
    ('Chris Wilson', NULL, 1.88, 90.5, 'm', '1988-11-05', 'Chris Wilson is a musician.');

--===============================================================================================================--
---8. Create Table Users
---Using SQL query create table Users with columns:

---· Id – unique number for every user. There will be no more than 263-1 users (auto incremented).
---· Username – unique identifier of the user. It will be no more than 30 characters (non Unicode) (required).
---· Password – password will be no longer than 26 characters (non Unicode) (required).
---· ProfilePicture – image with size up to 900 KB.
---· LastLoginTime
---· IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.

---Make the Id a primary key. Populate the table with exactly 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.

CREATE TABLE Users (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(30) NOT NULL,
    Password VARCHAR(26) NOT NULL,
    ProfilePicture VARBINARY(MAX), -- Maximum size, which can accommodate 900 KB
    LastLoginTime DATETIME,
    IsDeleted BIT
);

-- INSERT 5 records into the Users table
INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES
    ('user1', 'password1', NULL, '2023-09-27 10:00:00', 0),
    ('user2', 'password2', NULL, '2023-09-26 14:30:00', 1),
    ('user3', 'password3', NULL, '2023-09-25 08:45:00', 0),
    ('user4', 'password4', NULL, '2023-09-24 20:15:00', 1),
    ('user5', 'password5', NULL, '2023-09-23 12:20:00', 0);


--===============================================================================================================--
---9. Change Primary Key

---Using SQL queries modify table Users from the previous task.
---First remove the current primary key and then create a new primary key that would be a combination of fields Id and Usernam


ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07226EA070;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username);

--===============================================================================================================--
---10. Add Check Constraint

---Using SQL queries modify table Users.
---Add check constraint to ensure that the values in the Password field are at least 5 symbols long.

ALTER TABLE Users
ADD CONSTRAINT Check_PasswordLength CHECK (LEN(Password) >= 5);


--===============================================================================================================--
---11. Set Default Value of a Field

---Using SQL queries modify table Users. Make the default value of LastLoginTime field to be the current time.

ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime;


--===============================================================================================================--
---12. Set Unique Field

---Using SQL queries modify table Users.
---Remove Username field from the primary key so only the field Id would be primary key.
---Now add unique constraint to the Username field to ensure that the values there are at least 3 symbols long.

-- Step 1: Remove Username from the primary key
ALTER TABLE Users
DROP CONSTRAINT PK_Users; -- Assuming "PK_Users" is the name of the primary key constraint

-- Step 2: Add a new primary key constraint on Id only
ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id);

-- Step 3: Add a unique constraint to Username
ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE (Username);

-- Step 4: Add a check constraint for Username length
ALTER TABLE Users
ADD CONSTRAINT Check_UsernameLength CHECK (LEN(Username) >= 3);


--===============================================================================================================--
---13. Movies Database

---Using SQL queries create Movies database with the following entities:

---· Directors (Id, DirectorName, Notes)
---· Genres (Id, GenreName, Notes)
---· Categories (Id, CategoryName, Notes)
---· Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)

---Set the most appropriate data types for each column. Set a primary key to each table. Populate each table with exactly 5 records.
---Make sure the columns that are present in 2 tables would be of the same data type. 
---Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB

-- Create the Movies database
CREATE DATABASE Movies;
USE Movies;

-- Create the Directors table
CREATE TABLE Directors (
    Id INT PRIMARY KEY,
    DirectorName VARCHAR(255) NOT NULL,
    Notes VARCHAR(MAX)
);

-- Create the Genres table
CREATE TABLE Genres (
    Id INT PRIMARY KEY,
    GenreName VARCHAR(255) NOT NULL,
    Notes VARCHAR(MAX)
);

-- Create the Categories table
CREATE TABLE Categories (
    Id INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Notes VARCHAR(MAX)
);

-- Create the Movies table
CREATE TABLE Movies (
    Id INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    DirectorId INT,
    CopyrightYear INT,
    Length INT,
    GenreId INT,
    CategoryId INT,
    Rating DECIMAL(3, 1), -- Assuming rating can have one decimal place
    Notes VARCHAR(MAX),
    FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Insert records into the Directors table
INSERT INTO Directors (Id, DirectorName, Notes)
VALUES
    (1, 'Director 1', 'Notes 1'),
    (2, 'Director 2', 'Notes 2'),
    (3, 'Director 3', 'Notes 3'),
    (4, 'Director 4', 'Notes 4'),
    (5, 'Director 5', 'Notes 5');

-- Insert records into the Genres table
INSERT INTO Genres (Id, GenreName, Notes)
VALUES
    (1, 'Genre 1', 'Notes 1'),
    (2, 'Genre 2', 'Notes 2'),
    (3, 'Genre 3', 'Notes 3'),
    (4, 'Genre 4', 'Notes 4'),
    (5, 'Genre 5', 'Notes 5');

-- Insert records into the Categories table
INSERT INTO Categories (Id, CategoryName, Notes)
VALUES
    (1, 'Category 1', 'Notes 1'),
    (2, 'Category 2', 'Notes 2'),
    (3, 'Category 3', 'Notes 3'),
    (4, 'Category 4', 'Notes 4'),
    (5, 'Category 5', 'Notes 5');

-- Insert records into the Movies table
INSERT INTO Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
    (1, 'Movie 1', 1, 2021, 120, 1, 1, 8.5, 'Notes 1'),
    (2, 'Movie 2', 2, 2020, 105, 2, 2, 7.8, 'Notes 2'),
    (3, 'Movie 3', 3, 2019, 95, 3, 3, 6.4, 'Notes 3'),
    (4, 'Movie 4', 4, 2018, 110, 4, 4, 9.2, 'Notes 4'),
    (5, 'Movie 5', 5, 2017, 130, 5, 5, 8.0, 'Notes 5');


--===============================================================================================================--

-- 14. Car Rental Database

-- Using SQL queries create CarRental database with the following entities:

-- · Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)

-- · Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)

-- · Employees (Id, FirstName, LastName, Title, Notes)

-- · Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)

-- · RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)

-- Set the most appropriate data types for each column. Set a primary key to each table.
--   Populate each table with only 3 records. Make sure the columns that are present in 2 tables would be of the same data type.
--   Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check D

-- Create the CarRental database
CREATE DATABASE CarRental;

USE CarRental;

-- Create the Categories table
CREATE TABLE Categories (
    Id INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    DailyRate DECIMAL(10, 2) NOT NULL,
    WeeklyRate DECIMAL(10, 2) NOT NULL,
    MonthlyRate DECIMAL(10, 2) NOT NULL,
    WeekendRate DECIMAL(10, 2) NOT NULL
);

-- Create the Cars table
CREATE TABLE Cars (
    Id INT PRIMARY KEY,
    PlateNumber VARCHAR(15) NOT NULL,
    Manufacturer VARCHAR(255) NOT NULL,
    Model VARCHAR(255) NOT NULL,
    CarYear INT NOT NULL,
    CategoryId INT,
    Doors INT NOT NULL,
    Picture VARBINARY(MAX),
    Condition VARCHAR(50),
    Available BIT NOT NULL
);

-- Create the Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Title VARCHAR(50),
    Notes VARCHAR(MAX)
);

-- Create the Customers table
CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    DriverLicenceNumber VARCHAR(20) NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    ZIPCode VARCHAR(15) NOT NULL,
    Notes VARCHAR(MAX)
);

-- Create the RentalOrders table
CREATE TABLE RentalOrders (
    Id INT PRIMARY KEY,
    EmployeeId INT,
    CustomerId INT,
    CarId INT,
    TankLevel DECIMAL(5, 2),
    KilometrageStart INT,
    KilometrageEnd INT,
    TotalKilometrage INT,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    TotalDays INT NOT NULL,
    RateApplied DECIMAL(10, 2) NOT NULL,
    TaxRate DECIMAL(5, 2) NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL,
    Notes VARCHAR(MAX)
);

-- Insert records into the Categories table
INSERT INTO Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
    (1, 'Economy', 35.00, 200.00, 750.00, 50.00),
    (2, 'Compact', 45.00, 250.00, 900.00, 60.00),
    (3, 'Full-size', 55.00, 300.00, 1100.00, 70.00);

-- Insert records into the Cars table
INSERT INTO Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
    (1, 'ABC123', 'Toyota', 'Corolla', 2022, 1, 4, NULL, 'Good', 1),
    (2, 'XYZ456', 'Honda', 'Civic', 2021, 2, 4, NULL, 'Excellent', 1),
    (3, 'DEF789', 'Ford', 'Focus', 2020, 1, 4, NULL, 'Good', 1);

-- Insert records into the Employees table
INSERT INTO Employees (Id, FirstName, LastName, Title, Notes)
VALUES
    (1, 'John', 'Doe', 'Manager', NULL),
    (2, 'Jane', 'Smith', 'Sales Associate', NULL),
    (3, 'Bob', 'Johnson', 'Rental Agent', NULL);

-- Insert records into the Customers table
INSERT INTO Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
    (1, 'DL123456', 'Alice Johnson', '123 Main St', 'Cityville', '12345', NULL),
    (2, 'DL987654', 'David Smith', '456 Elm St', 'Townsville', '54321', NULL),
    (3, 'DL789012', 'Eve Wilson', '789 Oak St', 'Villagetown', '67890', NULL);

-- Insert records into the RentalOrders table
INSERT INTO RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
    (1, 1, 1, 1, 90.0, 1000, 1250, 250, '2023-09-01 09:00:00', '2023-09-03 15:00:00', 3, 200.00, 10.0, 'Completed', NULL),
    (2, 2, 2, 2, 85.0, 800, 950, 150, '2023-09-02 10:30:00', '2023-09-04 16:45:00', 3, 250.00, 10.0, 'Completed', NULL),
    (3, 3, 3, 3, 95.0, 1200, 1350, 150, '2023-09-03 11:15:00', '2023-09-05 14:20:00', 2, 180.00, 10.0, 'Completed', NULL);
