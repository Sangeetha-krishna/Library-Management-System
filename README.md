# Library-Management-System
The Library Management System SQL schema efficiently manages data for library branches, employees, books, customers, book issues, and returns. It includes scripts to create the database, define table relationships, and insert sample data for testing and demonstration purposes, ensuring smooth operations and easy access to information.

Library Management System - SQL

This project implements a Library Management System using SQL. It involves creating a database named library with six tables: Branch, Employee, Books, Customer, IssueStatus, and ReturnStatus. Each table is defined with specific attributes and relationships, including primary keys and foreign keys to ensure data integrity.

Database Schema:

1. Branch
This table stores information about the different branches of the library.

- Branch_no: Integer, Primary Key
- Manager_Id: Integer
- Branch_address: String
- Contact_no: String

2. Employee
This table stores information about the library employees.

- Emp_Id: Integer, Primary Key
- Emp_name: String
- Position: String
- Salary: Decimal
- Branch_no: Integer, Foreign Key references Branch(Branch_no)

3. Books
This table stores information about the books available in the library.

- ISBN: String, Primary Key
- Book_title: String
- Category: String
- Rental_Price: Decimal
- Status: String (yes/no to indicate availability)
- Author: String
- Publisher: String

4. Customer
This table stores information about the library customers.

- Customer_Id: Integer, Primary Key
- Customer_name: String
- Customer_address: String
- Reg_date: Date

5. IssueStatus
This table tracks the books that have been issued to customers.

- Issue_Id: Integer, Primary Key
- Issued_cust: Integer, Foreign Key references Customer(Customer_Id)
- Issued_book_name: String
- Issue_date: Date
- Isbn_book: String, Foreign Key references Books(ISBN)

6. ReturnStatus
This table tracks the books that have been returned by customers.

- Return_Id: Integer, Primary Key
- Return_cust: Integer
- Return_book_name: String
- Return_date: Date
- Isbn_book2: String, Foreign Key references Books(ISBN)
