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

--Some analysts forecast what is going to be the growth for real estate assets. We want to check if their forecast is true. 
--For each asset in the real_estate table, calculate the ratio between the value of a newer date to the value of an older date.
--For example, if there is an asset whose value in 2022-01-01 was 5 and in 2022-05-01 was 10 then that ratio is 10/5 = 2.
--Ignore all of the comparisons that the day difference between the two dates is smaller than 101.
--There are many dates for each asset so there are many ratios to compare. keep only the biggest ratio for each asset.
--divide this ratio with the matching forecast from the potential table (call this field ratio_forecast) and sort the results in descending order.
--The final result should have the asset_id and ratio_forecast.
--Keep only the assets where the ratio_forecast is bigger than 1.

with max_ratios as (
    select r1.asset_id,max((r2.value * 1.0)/r1.value) as max_ratio
from real_estate r1
join real_estate r2 
on r1.asset_id = r2.asset_id and r1.date < r2.date
where julianday(r2.date) - julianday(r1.date) > 100
group by r1.asset_id
)
select maxr.asset_id, (maxr.max_ratio/pt.forecast) as ratio_forecast
from max_ratios maxr
join potential pt 
on maxr.asset_id = pt.asset_id
where (maxr.max_ratio/pt.forecast) > 1
order by ratio_forecast desc;
