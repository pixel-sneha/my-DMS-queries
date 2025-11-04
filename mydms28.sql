--Write a query that returns:
--The total number of sales transactions,average quantity per sale
--The maximum price per unit,total revenue (sum of quantity * price_per_unit)
select count(product_id) as total_transactions,
avg(quantity) as avg_quantity,
max(price_per_unit) as max_unit_price,
sum(quantity*price_per_unit) as total_revenue
from sales;

--Calculate how much each item's price differs from the average price of all items.
--Display the item ID,price, and difference from the average.
--Name the difference column as diff_from_avg
select id,price, price - (select avg(price) from items)
 as diff_from_avg
 from items
 order by diff_from_avg desc;
