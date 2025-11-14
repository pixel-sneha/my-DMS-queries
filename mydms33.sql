--Find pairs of friends who are mutual friends (mutual friendship exists when person A's friend_id points to person B AND person B's friend_id points to person A). Display both friends names in a single row. Name the columns friend1 and friend2.
select f1.name as friend1, f2.name as friend2
from friends f1
join friends as f2 on (f1.id = f2.friend_id and f2.id = f1.friend_id)
where f1.id < f2.id;

