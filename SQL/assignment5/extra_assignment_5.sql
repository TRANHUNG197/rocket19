				/*extra_assignment_5*/

use adventureworks;

/*Question 1: Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name
của ProductSubcategory là 'Saddles'.*/

select * from productsubcategory where `name` = 'Saddles';

select `name` from product where ProductSubcategoryID = (select ProductSubcategoryID from productsubcategory where `name` = 'Saddles');