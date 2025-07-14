-- Request 2:
with
	unique_products as 
    (select
		count(distinct 
			if(fiscal_year = 2020, product_code, null)) as unique_products_2020,
		count(distinct 
			if(fiscal_year = 2021, product_code, null)) as unique_products_2021
	from fact_sales_monthly)
select
	*,
    concat(round(((unique_products_2021-unique_products_2020)/unique_products_2020)*100, 2), "%")
		as percentage_chg
from unique_products;