CREATE DATABASE library;

USE library;

-- Create table Branch
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
-- Insert data into table Branch 
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St, CityA', '1234567890'),
(2, 102, '456 Elm St, CityB', '2345678901'),
(3, 103, '789 Oak St, CityC', '3456789012'),
(4, 104, '321 Pine St, CityD', '4567890123'),
(5, 105, '654 Maple St, CityE', '5679001234');

-- Create table Employee
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
-- Insert data into table Employee
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Alice Smith', 'Manager', 75000, 1),
(102, 'Bob Johnson', 'Assistant Manager', 60000, 2),
(103, 'Charlie Lee', 'Librarian', 50000, 3),
(104, 'Diana Clark', 'Assistant Librarian', 45000, 4),
(105, 'Evan Martin', 'Clerk', 30000, 5);

-- Create table Books
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3) CHECK (Status IN ('yes', 'no')),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);
-- Insert data into table Books
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-3-16-148410-0', 'The Great Gatsby', 'Fiction', 15.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-14-028333-4', '1984', 'Dystopian', 12.00, 'no', 'George Orwell', 'Penguin Books'),
('978-1-56619-909-4', 'To Kill a Mockingbird', 'Fiction', 10.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-7432-7356-5', 'A Brief History of Time', 'Science', 20.00, 'yes', 'Stephen Hawking', 'Bantam Books'),
('978-0-452-28423-4', 'Moby-Dick', 'Fiction', 18.00, 'no', 'Herman Melville', 'Harper & Brothers');

-- Create table Customer
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
-- Insert data into table Customer
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'John Doe', '789 Birch St, CityA', '2023-01-15'),
(202, 'Jane Smith', '456 Cedar St, CityB', '2021-06-25'),
(203, 'Sam Brown', '123 Spruce St, CityC', '2020-11-10'),
(204, 'Lisa White', '321 Ash St, CityD', '2022-08-05'),
(205, 'Tom Black', '654 Willow St, CityE', '2023-03-22');

-- Create table IssueStatus
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
-- Insert data into table IssueStatus
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'The Great Gatsby', '2023-06-10', '978-3-16-148410-0'),
(302, 202, '1984', '2023-06-15', '978-0-14-028333-4'),
(303, 203, 'To Kill a Mockingbird', '2023-06-20', '978-1-56619-909-4'),
(304, 204, 'A Brief History of Time', '2023-06-25', '978-0-7432-7356-5'),
(305, 205, 'Moby-Dick', '2023-06-30', '978-0-452-28423-4');

-- Create table ReturnStatus
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- Insert data into table ReturnStatus
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'The Great Gatsby', '2023-07-01', '978-3-16-148410-0'),
(402, 202, '1984', '2023-07-05', '978-0-14-028333-4'),
(403, 203, 'To Kill a Mockingbird', '2023-07-10', '978-1-56619-909-4'),
(404, 204, 'A Brief History of Time', '2023-07-15', '978-0-7432-7356-5'),
(405, 205, 'Moby-Dick', '2023-07-20', '978-0-452-28423-4');

-- Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books.
SELECT B.Book_title, C.Customer_name
FROM IssueStatus I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

-- Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer C
WHERE Reg_date < '2022-01-01'
  AND NOT EXISTS (
      SELECT 1
      FROM IssueStatus I
      WHERE I.Issued_cust = C.Customer_Id
  );
  
  -- Display the branch numbers and the total count of employees in each branch.
  SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name
FROM IssueStatus I
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Retrieve book_title from book table containing history.
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name
FROM IssueStatus I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE B.Rental_Price > 25;

