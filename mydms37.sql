--Fetch all liquids with more than 5.677 density.
--Number the result (use the ROW_NUMBER() function) and call this column row_num

select id,density,
ROW_NUMBER() over() as row_num
from liquids
where density > 5.677;

--Select all plants with a hue greater than 0.34 and add two numbering columns:
--row_num_hue that will number the rows according to hue in ascending order
--row_num_score that will number the rows by the following formula: rough*hue in descending order
--return only the id and the two numbering columns. Order the result by the plant id in ascending order

Select id,
 row_number() over(order by hue asc) as row_num_hue,
 row_number() over(order by (rough*hue) desc) as row_num_score
from plants
where hue > 0.34
order by id;

--A factory is building doors. It needs to number the doors for each country and color combination that have a publication_year smaller than 2000. Name this column row_num.
--The doors should be numbered within each group in ascending order by their id. Doors without specs should be ignored. Sort the final result in ascending order by the id. 
select doors.id,doors_specs.country, doors_specs.color,
row_number() over(partition by country,color order by doors_specs.id asc) as row_num 
from doors_specs
join doors on 
doors_specs.id = doors.id 
where publication_year < 2000
order by doors_specs.id asc;

--Write a SQL query to analyze the sequence of door colors within each country, ordered by publication year.
--For each door space, show: The country,The color,The publication year
--A number representing the order of colors within each country based on publication year. Call this column color_sequence_number
select ds.country, ds.color, d.publication_year,
row_number() over(partition by ds.country order by d.publication_year) as color_sequence_number
from doors_specs ds 
join doors d on
ds.id = d.id
order by ds.country;

--Write a query that shows each air conditioner's efficiency along with the efficiency of the previous air conditioner installed (based on id). 
--Also, calculate the efficiency difference between the current and previous air conditioner. 
--Order the result by id and efficiency in ascending order.

select * from ( select id, efficiency,
lag(efficiency) over (order by id) as previous_efficiency,
efficiency - lag(efficiency) over (order by id) as efficiency_difference
from air_conditioners)
where previous_efficiency !=0
order by id, efficiency;

