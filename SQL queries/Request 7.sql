-- Request 7:
select
	monthname(s.date) as month_name,
	s.fiscal_year as fiscal_year,
    concat("$ ", round(sum(s.sold_quantity*g.gross_price)/1000000, 2), " M") as gross_sales_amount
from dim_customer c
join fact_sales_monthly s
on c.customer_code = s.customer_code
join fact_gross_price g
on s.product_code = g.product_code
and s.fiscal_year = g.fiscal_year
where c.customer = "Atliq Exclusive"
group by month_name, fiscal_year
order by fiscal_year;