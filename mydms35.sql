--Available tables and columns:
--enom_gilpane: part_id, rpm, watt, size
--Keep only the parts that have a quality value greater than the average quality.
--Return part_id and quality

ELECT part_id, ((rpm * adjusted_watt) / size) as quality
FROM (
    SELECT part_id, rpm, watt + (select avg(watt) from enom_gilpane) as adjusted_watt, size
    FROM enom_gilpane
    where (rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size)
       FROM enom_gilpane)
)

