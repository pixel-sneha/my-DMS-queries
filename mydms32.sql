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
