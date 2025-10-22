--for a cybersecurity firm, writing a query for given conditions:
--Its size is significantly different from the average normal event size of 50MB.consider files small er than 1MB or larger than 100MB as suspicious.
--It was created before the year 2000 , It has a missing name
--Identify all suspicious events based on the criteria mentioned above.
Return the event IDs and their names in descending order by their ID.
SELECT id, name
FROM events
WHERE (size<1 or size>100) or year<2000 or name is null
order by id desc;
