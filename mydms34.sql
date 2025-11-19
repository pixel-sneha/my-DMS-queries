--Find the sum of sales for each product of all tables together.
--The result should include the product_id and the total sales
--Sort the results by the total sales in descending order.
select product_id, sum(quantity_sold) as total_sales from
(select product_id, quantity_sold from sales_2009
union all select product_id, quantity_sold from sales_2010
union all select product_id, quantity_sold from sales_2011) as combined_sales
group by product_id
order by total_sales desc;

--write a query that First identifies "large devices" (devices with width greater than 200)
--Then calculates the average score for these large devices. Call this column as average_score
with large_devices as (
    select * from devices_specs 
    join devices_score on devices_score.device_id = devices_specs.device_id
    where width > 200
)
select avg(score) as average_score 
from large_devices;

--A device's quality is measured by (width/height)*num_features.
--Fetch all of the devices where the device's opinion is greater than the average quality and the device's score is less than the average quality. Return only the device_id.
--use the WITH clause
WITH avg_quality AS (
    SELECT AVG((width * 1.0 / height) * num_features) AS avg_q
    FROM devices_specs
)
SELECT ds.device_id
FROM devices_specs ds
JOIN devices_score dsc 
  ON ds.device_id = dsc.device_id
WHERE ds.opinion > (SELECT avg_q FROM avg_quality)
  AND dsc.score   < (SELECT avg_q FROM avg_quality);

