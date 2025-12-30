--Create a query that shows the region, total medal count (sum of all medals regardless of color), and two types of rankings:
--A regular_rank (with gaps) over the sum medals
--A dense_rank (without gaps) over the sum of medals
select region, sum(medal_count) as total_medals,
rank() over (order by sum(medal_count) desc) as  regular_rank,
dense_rank() over (order by sum(medal_count)desc) as dense_rank
from medals
group by region
order by total_medals desc, region asc

--Regions receive medals in competitions. Create a report that shows:
--Calculate for each region:
--total_medals: The sum of all medals they have
--rank_by_medals: Create a dense rank based on total_medals in ascending order (regions with fewer medals get better/lower ranks)
--Order the results by: rank_by_medals (ascending),region (alphabetically)
select region, sum(medal_count) as total_medals,
dense_rank() over (order by sum(medal_count) asc) as rank_by_medals
from medals
group by region
order by rank_by_medals, region;
