--for a cybersecurity firm, writing a query for given conditions
SELECT id, name
FROM events
WHERE (size<1 or size>100) or year<2000 or name is null
order by id desc;
