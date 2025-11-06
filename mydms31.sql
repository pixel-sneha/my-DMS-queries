--Write a query to find all items (select all columns)
-- where the price is higher than the average price of all items.

select * 
from shop
where price > (select avg(price) from shop);
