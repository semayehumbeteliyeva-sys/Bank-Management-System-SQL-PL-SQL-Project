# Bank-Management-System-SQL-PL-SQL-Project
## Project Purpose
This project is a Bank Loan Management Database developed using Oracle Database 21c, SQL, and PL/SQL.
The main purpose of the project is to design and implement a relational database for managing customers, branches, loans, and loan payments. It demonstrates practical SQL and PL/SQL skills, including database design, data manipulation, analytical reporting, automation, views, and audit logging.
The project is designed as a portfolio project to demonstrate hands-on experience with Oracle SQL and PL/SQL.
## Tools & Technologies
-Oracle Database 21c
-Oracle SQL Developer
-Oracle Data Modeler
-PL/SQL
## Project Structure
```text
bank-sql-project/
├── README.md
├── 01_tables.sql              # Table definitions with constraints
├── 02_data.sql                # Sample data (INSERT statements)
├── 03_plsql_payments.sql      # PL/SQL block for payment generation
├── 04_analytical_queries.sql  # Analytical SQL queries
├── 05_views.sql                # Views
├── 06_trigger_audit.sql        # Audit trigger and log table
├── bank_loan_er_diagram.png    #Entity -relationship diagram
```
## Database Structure
The database consists of the following main entities:
-**CUSTOMERS** - stores customer information
-**BRANCHES**- stores bank branch information
-**LOANS**- stores loan information, linked to `customers` and `branches` via foreign keys
-**PAYMENTS**-stores monthly loan payment records, linked to `loans` via foreign key
-**LOANS_AUDIT**-stores audit trail for loan closures,automatically populated via trigger
## Database Relationships
-One customer can have multiple loans (1:N)
-One branch can process multiple loans(1:N)
-One loan can have many payments(1:N)
## Database Features
-Normalized relational database schema following 3NF principles
-Primary keys, foreign keys, unique constraints, and check constraints for data integrity
-Customer, branch, loan, and payment management
- Automated monthly payment generation using PL/SQL and the annuity formula
- 12+ analytical SQL queries using:
  * JOIN
  * GROUP BY
  * Subqueries
  * CTEs
  * Window functions
  * RANK() OVER
  * SUM() OVER (PARTITION BY)
- Views for:
  * Active loans
  * Branch portfolio summary
  * Customer loan history
- Trigger-based audit logging for loan closures
-Oracle built-in functions such as ADD_MONTHS, MONTHS_BETWEEN, TRUNC, NVL, and EXISTS
## ER Diagram
<img width="886" height="1059" alt="bank_loan_er_diagram" src="https://github.com/user-attachments/assets/1a7a03ca-6818-4df5-bf5a-87c5a4028b4f" />
## Oracle Functions Used
ADD_MONTHS, MONTHS_BETWEEN, TRUNC, NVL, RANK() OVER, SUM() OVER PARTITION BY, EXISTS.
