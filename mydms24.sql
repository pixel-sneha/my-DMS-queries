--Fetch all of the cellphone models that start with the letter m,3rd letter is o, 
--the price range is between 1000 and 1500, and they support wifi_5g.
select model as id
from cellphones where model like 'm_o%'
 and price between 1000 and 1500
 and wifi_5g is not null;
