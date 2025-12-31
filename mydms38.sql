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

--Available tables and columns:
--picture_characteristics: day_of_month, ink_liters, colors_num
--We want to identify days where the artist used less resources (ink and colors) while still maintaining positive interest from people, while the artist should use less ink and less color to save costs.
--Calculate the day-over-day difference for:ink_liters,colors_num
--Filter the results to show only days where:
--ink_diff is negative (showing a decrease in ink usage)
--colors_diff is negative (showing a decrease in colors used)
--num_people_interested is positive (showing there is interest in the picture)
--Create a ranking column (day_rank) that:
--Ranks days from 1 to N based on num_people_interested
--Higher number of interested people should get a lower rank (1 being the best)
--Return: day_of_month,day_rank
with less_res as (
    select pc.day_of_month, pin.num_people_interested,
    pc.ink_liters - LAG(pc.ink_liters, 1) OVER (ORDER BY pc.day_of_month) as ink_diff,
    pc.colors_num - lag(pc.colors_num, 1) over (order by pc.day_of_month) as colors_diff
    from picture_characteristics pc
    
    join picture_interests pin 
    on pc.day_of_month = pin.day_of_month
    
)
select day_of_month,
row_number() over (order by num_people_interested desc) as day_rank
from less_res
where (ink_diff < 0 
and colors_diff < 0)
and num_people_interested > 0
order by day_rank asc

--Write a query to compare each box with the next box in sequence. A box can fit into the next box if and only if the next box's size is strictly greater than the current box's size. Follow these steps:
--Create a column named can_fit_next that shows:
--1 (true) if the box can fit into the next box
--0 (false) if it cannot fit
--The last box will automatically get NULL as there is no next box to compare with
--Filter to show only the boxes that can fit into the next box (where can_fit_next = 1)
--Return the box_id
--Order the results by box_id in ascending order
with will_fit as (
    select box_id,
        case
            when lead(size) over(order by box_id) is null then null 
            when size < lead(size) over(order by box_id) then 1
            else 0
        end as can_fit_next
    from boxes
)
select box_id
from will_fit
where can_fit_next is 1
order by box_id
