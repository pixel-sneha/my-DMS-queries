--Old Expired Juices
--Juices where the expiration year is MORE than 6 years before the current year (current_year - expiration_year > 6)
--Almost Expired Juices
--Juices expiring in the current year,OR juices expiring next year
--These need to be sent for renewal
--Extract the IDs of juices that meet either of these criteria
--Rename the ID column to 'to_renew'
--Sort results by processing priority:
--Most urgent first (oldest expired juices).Then almost expired juices
--Use (current_year - expiration_year) for sorting
select id as to_renew 
from beverages 
where (current_year - expiration_year>6) 
or (expiration_year - current_year = 1) 
or (expiration_year - current_year = 0)
order by expiration_year-current_year;
