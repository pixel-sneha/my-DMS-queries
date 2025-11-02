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

--A quartic function is defined: f(x) = ax4+bx3+cx2+dx+e
--constant parameters:a = 3,b = 5,c = 0.9,d = 2.2,e = 1
--Fetch the ids and the quartic function where x is the id, and rename the column to quartic
--without using built in functions like power
select id, 3*(id*id*id*id)+5*(id*id*id)+0.9*(id*id)+2.2*(id)+1
as quartic
from items;
