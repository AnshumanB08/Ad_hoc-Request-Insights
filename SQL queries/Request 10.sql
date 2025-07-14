-- Request 10:
with
	products_sold as
    (select
		p.division as division,
		p.product_code as product_code,
		p.product as product,
		sum(sold_quantity) as total_sold_quantity
	from dim_product p
	join fact_sales_monthly s
	on p.product_code = s.product_code
	where s.fiscal_year = 2021
	group by division, product_code, product
    order by total_sold_quantity),
    products_sold_per_division as
	(select
		*,
		dense_rank() over(partition by division order by total_sold_quantity desc)
			as rank_order
	from products_sold)
select
	*
from products_sold_per_division
where rank_order <= 3;