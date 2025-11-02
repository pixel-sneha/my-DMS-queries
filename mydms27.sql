--Fetch all of the game ids that are not played in the winter.
--Winter dates are: 2022-12-21 - 2023-03-20. Only these days should not be included.
--Sort them by the date in descending order and rename the column to game
select id as game
from games
where date not between '2022-12-21' and '2023-03-2020'
order by date desc;

--Fetch all of the events that last less than three days using julianday()
select id
from events
where julianday(end) - julianday(start) < 3;

-- Get year
SELECT STRFTIME('%Y', '2023-05-15')
-- Returns: 2023
-- Get month
SELECT STRFTIME('%m', '2023-05-15')
-- Returns: 05
-- Get day
SELECT STRFTIME('%d', '2023-05-15')
-- Returns: 15
-- Show combination of year and day
SELECT STRFTIME('%Y:%d', '2023-05-15')
-- Returns: 2023:15
--Write a query that shows:The event ID,The start date formatted as "DD-MM-YYYY".
--The end date formatted as "DD-MM-YYYY". The duration in days between start and end, rounded to the nearest whole number. Call this column duration_days
--Filter only the rows that the year of the start column is 2009 (STRFTIME() returns a string and not a number).
--Sort the results by the duration days in descending order.

select id, strftime('%d-%m-%Y',start) as formatted_start,
strftime('%d-%m-%Y',end) as formatted_end,
round(julianday(end) - julianday(start)) as duration_days
from events
where strftime('%Y',start) = '2009'
order by duration_days desc;
