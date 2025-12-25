--Available tables and columns:
--enom_gilpane: part_id, rpm, watt, size
--Keep only the parts that have a quality value greater than the average quality.
--Return part_id and quality

SELECT part_id, ((rpm * adjusted_watt) / size) as quality
FROM (
    SELECT part_id, rpm, watt + (select avg(watt) from enom_gilpane) as adjusted_watt, size
    FROM enom_gilpane
    where (rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size)
       FROM enom_gilpane)
)

--calculate the same quality for all products 
--(Each table is a product) and combine them all using UNION ALL:

with filtered_quality_1 as
(
    select part_id, ((rpm* adj_watt_1)/ size) as quality
    from (
        select part_id, rpm, watt + (select avg(watt) from enom_gilpane) as adj_watt_1 , size
        from enom_gilpane
        where (rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM enom_gilpane)) / size)
       FROM enom_gilpane)
    ) as t1
    ),
    filtered_quality_2 as ( select part_id, ((rpm* adj_watt_2)/ size) as quality
    from (
        select part_id, rpm, watt + (select avg(watt) from castle_loctus) as adj_watt_2 , size
        from castle_loctus
        where (rpm * (watt + (SELECT AVG(watt) FROM castle_loctus)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM castle_loctus)) / size)
       FROM castle_loctus)
    ) as t2
    ),
    filtered_quality_3 as  ( select part_id, ((rpm* adj_watt_3)/ size) as quality
    from (
        select part_id, rpm, watt + (select avg(watt) from honpan_bilopsa) as adj_watt_3 , size
        from honpan_bilopsa
        where (rpm * (watt + (SELECT AVG(watt) FROM honpan_bilopsa)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM honpan_bilopsa)) / size)
       FROM honpan_bilopsa)
    ) as t3 
    ),

    filtered_quality_4 as ( select part_id, ((rpm* adj_watt_4)/ size) as quality
    from (
        select part_id, rpm, watt + (select avg(watt) from yurnol_qoltam) as adj_watt_4 , size
        from yurnol_qoltam
        where (rpm * (watt + (SELECT AVG(watt) FROM yurnol_qoltam)) / size) >
      (SELECT AVG(rpm * (watt + (SELECT AVG(watt) FROM yurnol_qoltam)) / size)
       FROM yurnol_qoltam)
    ) as t4     
    ),
    quality_table AS (
    SELECT * FROM filtered_quality_1
    UNION ALL
    SELECT * FROM filtered_quality_2
    UNION ALL
    SELECT * FROM filtered_quality_3
    UNION ALL
    SELECT * FROM filtered_quality_4
)
    SELECT part_id, quality
    FROM quality_table;
