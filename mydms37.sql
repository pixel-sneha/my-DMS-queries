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
