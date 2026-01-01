--for this challenge, we have creatures that want to find a significant other. We need to help them find their match.
--Each creature has a preference value and either has legs or doesn't have legs.
--rules:
--Creatures are matched ONLY with others sharing the same has_legs value
--Within each group (has_legs true/false), order creatures by preference
--Assign couple_matcher numbers using NTILE(total_creature_count/2)
--Both groups will use the same couple_matcher range (1 to N)
WITH num_couples AS (
    SELECT COUNT(*) / 2
    FROM creatures
)
SELECT creature_name,
    NTILE((SELECT * FROM num_couples)) OVER (PARTITION BY has_legs ORDER BY preference ) as couple_matcher
FROM creatures
ORDER BY couple_matcher, creature_name

--For each junk_id we would like to add the following columns:
--even_num - row number from 2 to 2*n (n is the number of rows in the table) in jumps of 2: 2, 4, 6, 8, etc., ordered by junk_id
--num_piece - represents a group (using NTILE) that goes from 3 to 9 in jumps of 3: 3, 6, 9 (only 3 groups).
--avg_id - the average id of the current row and the 2 rows before it only in the same group
--piece_rank - dense rank of each group order by the avg_id

WITH stats AS(
    SELECT 
        junk_id,
        ROW_NUMBER() OVER (ORDER BY junk_id) * 2 as even_num,
        NTILE(3) OVER (ORDER BY junk_id) * 3 as num_piece
    FROM junk
), stats2 AS (
    SELECT *,
    AVG(junk_id) OVER (PARTITION BY num_piece ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as avg_id
    FROM stats
)

SELECT 
    *,
    DENSE_RANK() OVER (PARTITION BY num_piece ORDER BY avg_id) as piece_rank
FROM stats2
