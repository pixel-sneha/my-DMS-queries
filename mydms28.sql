--Write a query that returns:
--The total number of sales transactions,average quantity per sale
--The maximum price per unit,total revenue (sum of quantity * price_per_unit)
select count(product_id) as total_transactions,
avg(quantity) as avg_quantity,
max(price_per_unit) as max_unit_price,
sum(quantity*price_per_unit) as total_revenue
from sales;

