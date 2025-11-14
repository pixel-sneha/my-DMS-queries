--Find pairs of friends who are mutual friends (mutual friendship exists when person A's friend_id points to person B AND person B's friend_id points to person A). Display both friends names in a single row. Name the columns friend1 and friend2.
select f1.name as friend1, f2.name as friend2
from friends f1
join friends as f2 on (f1.id = f2.friend_id and f2.id = f1.friend_id)
where f1.id < f2.id;

--For each person in the friends table. A friend-of-friend connection occurs when person A is friends with person B, who is in turn friends with person C. List these connections as three columns:
--Don't include cases where friend3 is the same person as friend1
--Order the results by friend1's name in descending order
select f1.name as friend1, f2.name as friend2, f3.name as friend3
from friends f1
join friends as f2 on f1.friend_id = f2.id 
join friends as f3 on f2.friend_id = f3.id
where f1.id != f3.id
order by f1.name desc;
