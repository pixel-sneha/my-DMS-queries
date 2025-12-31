--Divide creatures into 3 groups based on their preference values, but only consider creatures that have legs (where has_legs = 'YES'). Return the creature_name, preference, and their group_number (1, 2, or 3). Order the results by preference in ascending order.
select creature_name, preference,
ntile(3) over(order by preference) as group_number
from creatures
where has_legs = 'YES'

--For each book, display the book name, its total pages, the number of words on each page, and calculate:
--The maximum number of words found on any page in that book
--The average number of words per page for the entire book
--The difference between the current page's words and the book's average words per page
--Display the results ordered by book and page number.

select book, page, words,
max(words) over(partition by book) as max_words_in_book,
avg(words) over(partition by book) as avg_words_per_page,
words - avg(words) over(partition by book) as diff_from_avg
from books
order by book, page
