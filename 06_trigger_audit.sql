-- Audit log table for tracking loan closures
create table loans_audit(
audit_id number generated as identity constraint pk_audit_id primary key,
loan_id number,
action_type varchar2(10),
old_close_date date,
new_close_date date,
action_date date default sysdate
);

-- Trigger: automatically logs when a loan's close_date changes
create or replace trigger trg_loan_close_audit
after update of close_date on loans
for each row
begin
insert into loans_audit(loan_id, action_type, old_close_date, new_close_date)
values (:OLD.loan_id, 'UPDATE', :OLD.close_date, :NEW.close_date);
END;
/