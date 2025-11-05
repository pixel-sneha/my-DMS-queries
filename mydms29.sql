--Calculate, for each food type, the average pH and the difference between the maximum and minimum pH values.
--Sort the results by the difference in descending order.
--Use the ROUND(value, decimal) to round each result to two decimal places.
select type, round(avg(pH),2) as ph_average, round(max(pH) - min(pH),2) as ph_max_min_diff
from foods
group by type
order by max(pH) - min(pH) desc;

--We need to return the average magnitude for each location of all of the major earthquakes
--A major earthquake is defined as:
--The amplitude is greater or equal to 1
--The period of the waves is greater or equal to 1 minute
--we will use a different formula: M = (A/T)2 / T, which is equivalent to M = ((A/T)*(A/T)) / T.
--Return the location and the average magnitude of each location while including only the major earthquakes (name the column avg_magnitude). Include in your result only the locations where the avg_magnitude is greater than 1
--Round the results to 2 decimal places
select location, round(avg(((amplitude/period)*(amplitude/period)) / period), 2) as avg_magnitude
from earthquakes
where amplitude >= 1 AND period >= 1
group by location
having avg_magnitude > 1
