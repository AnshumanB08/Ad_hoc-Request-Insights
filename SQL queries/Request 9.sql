-- Request 9:
with 
	sales_per_channel as
    (select
		c.channel as channel,
		round(sum(s.sold_quantity*g.gross_price)/1000000, 2) as gross_sales
	from dim_customer c
	join fact_sales_monthly s
	on c.customer_code = s.customer_code
	join fact_gross_price g
	on s.product_code = g.product_code
	and s.fiscal_year = g.fiscal_year
	where s.fiscal_year = 2021
	group by channel)
select
	channel,
    concat("$ ", gross_sales) as gross_sales_mln,
    concat(round(gross_sales/sum(gross_sales) over()*100, 2), "%") as percentage
from sales_per_channel
order by percentage desc;