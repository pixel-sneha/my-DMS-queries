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
