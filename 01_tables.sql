--Customers table
create table customers(
customer_id number generated as identity constraint pk_customer_id primary key,
first_name varchar2(50) not null,
last_name varchar2(50) not null,
gender varchar2(2),
birth_date date ,
city varchar2(50),
phone_number varchar2(20) unique,
open_date date default sysdate not null,
close_date date,
constraint ch_customer_date check(close_date is null or open_date<=close_date),
constraint ch_gender check(gender in('M','F')));
--Branches table
create table branches(
branch_id number  generated as identity constraint pk_branch_id primary key,
branch_name varchar2(50) not null,
city varchar2(50) not null);
--Add branch_id column to customers(link customer to a branch)
alter table customers
add branch_id number;

alter table customers
add constraint fk_customer_branch
foreign key (branch_id)
references branches (branch_id);

-- Loans Table(references customers and branches)
create table loans(
loan_id number generated as identity constraint pk_loan_id primary key,
customer_id number not null references customers(customer_id),
branch_id number not null references branches(branch_id),
loan_type varchar2(50) not null,
loan_amount number not null,
interest_rate number(5,2) not null,
loan_term_month number (5,0) not null,
start_date date default sysdate not null,
close_date date,
constraint ch_loan_amount check(loan_amount>0),
constraint ch_interest_rate check(interest_rate>0),
constraint ch_loan_term_month check (loan_term_month>0),
constraint ch_close_date check(close_date is null or start_date<=close_date));

--Payments table(references loans)
CREATE TABLE payments(
payment_id NUMBER GENERATED AS IDENTITY CONSTRAINT pk_payment_id PRIMARY KEY,
loan_id NUMBER NOT NULL,
payment_date DATE NOT NULL,
payment_amount NUMBER NOT NULL,
principal_amount NUMBER NOT NULL,
interest_amount NUMBER NOT NULL,
status VARCHAR2(20) DEFAULT 'PAID' NOT NULL,
CONSTRAINT fk_payment_loan FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
CONSTRAINT ch_payment_amount CHECK(payment_amount>0),
CONSTRAINT ch_interest_amount check(interest_amount>=0),
CONSTRAINT ch_principal_amount check (principal_amount>0),
CONSTRAINT ch_payment_status CHECK(status IN ('PAID','LATE','MISSED'))
);




