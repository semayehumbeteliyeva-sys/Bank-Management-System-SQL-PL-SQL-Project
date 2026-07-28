--her filialin umumi kredit portfeli
select
b.branch_name,
count(l.loan_id) as loan_count,
sum(loan_amount) as total_amount
from branches b left join loans l
on b.branch_id=l.branch_id
group by branch_name
order by total_amount desc;

--her mushterinin kredit tarixcesi
select
c.first_name,
c.last_name,
l.loan_type,
l.loan_amount,
l.interest_rate
from customers c left join loans l
on c.customer_id=l.customer_id
order by l.loan_amount asc;

--filial uzre umumi orta faiz derecesinden yuksek olan filiallar
select
b.branch_name,
round(avg(l.interest_rate),2) as avg_rate
from branches b left join loans l
on b.branch_id=l.branch_id
group by b.branch_name
having avg(l.interest_rate)>(select avg(interest_rate) from loans);


--kredit tipi uzre stastika
select
loan_type,
count(*) as count_type,
avg(loan_amount) as avg_amount,
max(loan_amount) as max_amount
from loans
group by loan_type;

--umumi orta faizden yuksek olan kreditler
select
l.loan_id,
l.customer_id,
c.first_name,
c.last_name,
l.interest_rate,
l.loan_type
from customers c inner join loans l
on c.customer_id=l.customer_id
where l.interest_rate>(select avg(interest_rate) from loans);

--her tip uzre umumi orta faizden yuksek kreditler
select
loan_id,
customer_id,
interest_rate,
loan_type
from loans l
where interest_rate>(select avg(interest_rate) from loans where loan_type=l.loan_type);

--her filialin en boyuk krediti
select distinct branch_id,
loan_id,
loan_amount,
first_value(loan_id)over (partition by branch_id order by loan_amount desc)
from loans;

--yasa gore mushteri sayi
select 
count(*) as "say",
case 
when trunc(months_between(sysdate,birth_date)/12)<30 then '18-29'
when trunc (months_between(sysdate,birth_date)/12)<50 then '30-49'
else '50+'
end as " yaş bölgüsü"
from customers
group by case 
when trunc(months_between(sysdate,birth_date)/12)<30 then '18-29'
when trunc (months_between(sysdate,birth_date)/12)<50 then '30-49'
else '50+'
end ;

--ay uzre odenis cemi
select
sum(payment_amount) as umumi_odeme,
to_char(payment_date,'mm.yyyy') as ayliq_odeme
from payments
group by to_char(payment_date,'mm.yyyy')
order by ayliq_odeme;

--hansi mushterinin hesabi baglanib, amma kredit aktivdir

select 
c.customer_id,
c.first_name,
c.last_name
from customers c
where close_date is not null
and exists (select 1 from loans l where l.customer_id=c.customer_id);

with tbl as (select
l.customer_id,
sum(nvl(p.interest_amount,0)) as total_interest
from loans l left join payments p
on l.loan_id=p.loan_id 
group by l.customer_id),
ranked as (select
tbl.*,
rank() over (order by total_interest desc) as rn
from tbl)
select * from ranked where rn<=5;

--her kreditin odenmis esas borcu
select 
loan_id,
payment_date,
principal_amount,
sum(principal_amount) over (partition by loan_id order by payment_date) as paid_so_far
from payments
order by loan_id,payment_date;

--kredit goturme sayina gore en aktiv mushteriler
select
c.customer_id,
c.first_name,
c.last_name,
count(l.loan_id) as say
from customers c inner join loans l
on c.customer_id=l.customer_id
group by c.customer_id,c.first_name,c.last_name
having count(loan_id)>1;
