-- Request 4:
with
	products_by_segment as 
    (select
		p.segment as segment,
		count(distinct 
			if(s.fiscal_year = 2020, s.product_code, null)) as product_count_2020,
		count(distinct 
			if(s.fiscal_year = 2021, s.product_code, null)) as product_count_2021
	from dim_product p
    join fact_sales_monthly s
    on p.product_code = s.product_code
    group by segment)
select
	*,
    product_count_2021-product_count_2020 as difference
from products_by_segment
order by difference desc;