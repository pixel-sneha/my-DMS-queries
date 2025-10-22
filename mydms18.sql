--Fetch all of the people whose name starts with Kand ends with a 
--and order the results by the names in descending order.
select * from people
where name like 'K%a'
order by name desc;
