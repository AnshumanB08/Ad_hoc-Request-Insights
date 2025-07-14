-- Request 6:
select
	c.customer_code as customer_code,
    c.customer as customer,
	concat(round(avg(d.pre_invoice_discount_pct*100), 2), "%")
		as average_discount_percentage
from dim_customer c
join fact_pre_invoice_deductions d
on c.customer_code = d.customer_code
where c.market = "India"
and d.fiscal_year = 2021
group by c.customer, c.customer_code
order by avg(d.pre_invoice_discount_pct) desc
limit 5;