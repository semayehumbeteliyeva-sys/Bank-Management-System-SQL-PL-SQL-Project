-- View 1: Full customer + loan summary
create view v_customer_loan_summary as
select c.customer_id, c.first_name, c.last_name, c.city,
       l.loan_id, l.loan_type, l.loan_amount, l.interest_rate, l.start_date, l.close_date
from customers c
inner join loans l on c.customer_id = l.customer_id;

-- View 2: Active (not yet closed) loans
create view v_active_loans as
select l.loan_id, l.customer_id, l.loan_type, l.loan_amount, l.close_date
from loans l
where l.close_date IS NULL OR l.close_date > sysdate;

-- View 3: Branch loan portfolio summary
create view v_branch_portfolio as
select b.branch_name, count(l.loan_id) as loan_count, sum(l.loan_amount) as total_amount
from branches b
join loans l on b.branch_id = l.branch_id
group by b.branch_name;