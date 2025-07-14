-- Request 8:
-- Query type 1:
select
    concat("Q", quarter(date_add(date, interval 4 month))) as fiscal_quarter,
    sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year = 2020
group by fiscal_quarter
order by total_sold_quantity desc;

-- Query type 2:
select
	case
		when month(date) in (9,10,11) then "Q1"
        when month(date) in (12,1,2) then "Q2"
        when month(date) in (3,4,5) then "Q3"
        else "Q4"
	end as fiscal_quarter,
    sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year = 2020
group by fiscal_quarter
order by total_sold_quantity desc;