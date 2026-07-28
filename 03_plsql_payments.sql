---- PL/SQL block: auto-generate monthly payment records using annuity formula
DECLARE
  v_monthly_rate    NUMBER;
  v_monthly_payment NUMBER;
  v_balance         NUMBER;
  v_interest_amt    NUMBER;
  v_principal_amt   NUMBER;
  v_pay_date        DATE;
BEGIN
  FOR ln IN (SELECT loan_id, loan_amount, interest_rate, loan_term_month, start_date
             FROM loans)
  LOOP
    v_balance      := ln.loan_amount;
    v_monthly_rate := ln.interest_rate / 100 / 12;

    v_monthly_payment := v_balance * v_monthly_rate * POWER(1+v_monthly_rate, ln.loan_term_month)
                          / (POWER(1+v_monthly_rate, ln.loan_term_month) - 1);

    FOR i IN 1..ln.loan_term_month LOOP
      v_pay_date := ADD_MONTHS(ln.start_date, i);

      EXIT WHEN v_pay_date > SYSDATE;

      v_interest_amt  := v_balance * v_monthly_rate;
      v_principal_amt := v_monthly_payment - v_interest_amt;
      v_balance       := v_balance - v_principal_amt;

      INSERT INTO payments(loan_id, payment_date, payment_amount, principal_amount, interest_amount, status)
      VALUES (ln.loan_id, v_pay_date, v_monthly_payment, v_principal_amt, v_interest_amt, 'PAID');
    END LOOP;
  END LOOP;
  COMMIT;
END;
/