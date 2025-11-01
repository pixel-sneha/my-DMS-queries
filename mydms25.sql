--Every minister that sits on an even numbered sit
--Your job is to return all of the "safe" ministers sits
--want to continue serving in the next government while 
--excluding any minister who spoke a bad word.

select sit 
from ministers 
where (sit%2=0) 
and (is_next_gov = 1 or is_next_gov='yes') 
and (is_spoke_bad = 0 or is_spoke_bad='no');

--Fetch the top 5 severe criminal names
--order by severe_score in descending order
--A severe criminal is someone who matches all of the following criteria:
--report is either null, or the report contains one of the following letters: g, b, G, or B.
--map is one of the following places: Caerleon, Dewsbury, Kirkwall, Findochty.
--Name the column as worst_criminals.
select name as worst_criminals 
from police_report 
where (report is null or report like '%g%' or report like '%b%'or report like '%G%' or report like '%B%') 
and map in ('Caerleon','Dewsbury','Kirkwall','Findochty')
order by severe_score desc
limit 5;
