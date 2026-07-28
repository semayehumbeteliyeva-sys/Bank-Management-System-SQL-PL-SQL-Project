# Bank-Management-System-SQL-PL-SQL-Project
## Project Overview
A relational database project developed using Oracle SQL and PL/SQL to manage customers,bank branches,loans,and loan payments. The prject demonstrates database design,relational database concepts,SQL queries,constraints, and PL/SQL functionality.
## Database Structure
The database consists of the following main entities:
-CUSTOMERS -customer information
-BRANCHES-bank branch information
-LOANS-loan information, linked to `customers` and `branches` via foreign keys
-PAYMENTS-monthly payment records, linked to `loans` via foreign key
-LOANS_AUDIT-audit trail for loan closures,automatically populated via trigger
## ER Diagram
<img width="886" height="1059" alt="bank_loan_er_diagram" src="https://github.com/user-attachments/assets/1a7a03ca-6818-4df5-bf5a-87c5a4028b4f" />
## Tools & Technologies
-Oracle Database 21c
-Oracle SQL Developer
-Oracle Data Modeler
-PL/SQL
## Project Structure
```
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
## Database Relationships
-One customer can have multiple loans (1:N)
-One branch can process multiple loans(1:N)
-One loan can have many payments(1:N)
## Database Features
-Normalized relational schema (3NF) with primary keys, foreign keys, and check constraints
- PL/SQL block that automatically generates monthly payment records using the annuity formula
- 12+ analytical SQL queries using JOIN, GROUP BY,subqueries,window functions (rank,sum over partition by ), and CTEs
- Views for active loans,branch portfolio summary, and customer loan history
- Trigger-based audit log that automatically tracks loan closures
## Oracle Functions Used
ADD_MONTHS, MONTHS_BETWEEN, TRUNC, NVL, RANK() OVER, SUM() OVER PARTITION BY, EXISTS.
