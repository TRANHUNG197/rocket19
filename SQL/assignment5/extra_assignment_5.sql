				/*extra_assignment_5*/

use adventureworks;     

-- Exercise 1: Subquery :

/*Question 1: Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name
của ProductSubcategory là 'Saddles'.*/

select * from productsubcategory where `name` = 'Saddles';

select `name` from product where ProductSubcategoryID = (select ProductSubcategoryID from productsubcategory where `name` = 'Saddles');


/*Question 2: Thay đổi câu Query 1 để lấy được kết quả sau.*/


select `name` from product where (substring_index(`name`, ' ', 1)) like'bo%';

select `name` from product where ProductSubcategoryID = (select ProductSubcategoryID from productsubcategory where 'bo%');


/*Question 3:
Viết câu query trả về tất cả các sản phẩm có giá rẻ nhất (lowest ListPrice) và Touring
Bike (nghĩa là ProductSubcategoryID = 3)
Hướng dẫn: sử dụng hàm MIN() trong subquery để trả về ListPrice thấp nhất*/


select `name` from product where ProductSubcategoryID =  3  having (select min(ListPrice) from product);

select min(ListPrice) from product;

select ProductID from product where min(ListPrice) group by listprice;


-- Exercise 2: JOIN nhiều bảng:
/*Question 1: Viết query lấy danh sách tên country và province được lưu trong
AdventureWorks2008sample database.*/



