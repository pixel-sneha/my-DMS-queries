--Create two calculated columns:
--Take the price column,Multiply it by 2,Subtract 20 from the result
--Take the quantity column,Divide it by 1.5,Add 5 to the result
select (price*2) - 20 as high_mix_op,
(quantity/1.5)+ 5 as low_mix 
from products;

--column called total_value that multiplies the price by quantity and adds a fixed shipping cost of 15
--column called discounted_value that First multiplies the price by quantity
--Then applies a 20% discount (multiply by 0.8),Finally adds a fixed shipping cost of 10
select (price * quantity) + 15 as total_value,
(price * quantity)*0.8 + 10 as discounted_value
from products;

--Create a query that:
--Shows the product ID,Assigns each product to one of three quality control teams (0, 1, or 2), call this column as quality_control
--Only includes products with odd quantities
select id, (id % 3) as quality_control 
from products 
where quantity%2=1;

