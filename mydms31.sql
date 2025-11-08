--Write a query to find all items (select all columns)
-- where the price is higher than the average price of all items.

select * 
from shop
where price > (select avg(price) from shop);

--Find the average of ALL quantities (This is the subquery)
--for each category, sum their quantities and compare with this average (use the HAVING keyword for group by)
select category, sum(quantity) as total_quantity 
from shop
group by category
having sum(quantity) > (select avg(quantity) from shop);

--calculate the average price across all items within the specified date range (2015-01-01  to 2015-03-18) 
--Add this average price to each item's original price to get the correct price value --For each category,
--calculate the total revenue by multiplying the corrected price by the quantity and summing these values 
--Present the results as (category, total_revenue) pairs, sorted by total revenue in descending order

SELECT category, SUM(price * quantity) AS total_revenue
FROM (
    SELECT price + (SELECT AVG(price) FROM shop WHERE list_date BETWEEN '2015-01-01' AND '2015-03-18') AS price, quantity, category, list_date
    FROM shop
    WHERE list_date BETWEEN '2015-01-01' AND '2015-03-18'
)
GROUP BY category
ORDER BY total_revenue DESC
