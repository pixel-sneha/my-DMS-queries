--As the manager of a scooter shop,Your task involves two steps:
--First, Add to all scooter prices in the shop the overall average price.
--Then, Calculate the average price for each brand, considering only good and original scooters (i.e., scooters with a model name and lights).
--The result should include the brand and the average price - avg_price. 
--Sort the results by the average price in ascending order.
select brand, avg(price) as avg_price
from (select price + (select avg(price) from scooters) as price,has_lights,model,brand 
from scooters)
as updated_price 
where has_lights = 1 and model is not null
group by brand
order by avg_price;

--Available tables and columns: beans: brand, density, diameter_wide, shade
--You are the owner of a coffee shop.There are several criteria for selecting which beans to use.filter the beans based on these conditions:
--All beans must have a diameter greater than the average diameter of all beans in the table
--For light beans: keep only those where the ratio of density to diameter is greater than 0.01
--For dark beans: keep all of them
--For semi-dark beans: exclude all of them (they are considered unsuitable)
--For each brand that meets these criteria, calculate their average density. Only keep brands where the average density is less than 0.8.
--Return the brand name and their average density (name the column avg_density) rounded to 3 decimal places. Sort the results by average density in ascending order.
SELECT brand, ROUND(AVG(density), 3) as avg_density
FROM beans
WHERE diameter_wide > (SELECT AVG(diameter_wide) FROM beans)
AND (shade = 'dark' OR (shade = 'light' AND density/diameter_wide > 0.01))
GROUP BY brand
HAVING avg_density < 0.8
ORDER BY avg_density
