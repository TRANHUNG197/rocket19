				/*extra_assignment_5*/

use adventureworks;     

-- Exercise 1: Subquery :

/*Question 1: Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name
của ProductSubcategory là 'Saddles'.*/

select * from productsubcategory where `name` = 'Saddles';

select `name` from product where ProductSubcategoryID = (select ProductSubcategoryID from productsubcategory where `name` = 'Saddles');


/*Question 2: Thay đổi câu Query 1 để lấy được kết quả sau.*/

select `name` from product where ProductSubcategoryID in (select ProductSubcategoryID from productsubcategory where `name` like 'bo%');


/*Question 3:
Viết câu query trả về tất cả các sản phẩm có giá rẻ nhất (lowest ListPrice) và Touring
Bike (nghĩa là ProductSubcategoryID = 3)
Hướng dẫn: sử dụng hàm MIN() trong subquery để trả về ListPrice thấp nhất*/


select `name` from product where ProductSubcategoryID =  3  and listprice = (select min(ListPrice) from product where ProductSubcategoryID =  3);

select min(ListPrice) from product;

select ProductID from product where min(ListPrice) group by listprice;


-- Exercise 2: JOIN nhiều bảng:
/*Question 1: Viết query lấy danh sách tên country và province được lưu trong
AdventureWorks2008sample database.*/

select * from stateprovince;

select ct.name, st.name
from countryregion ct 
join stateprovince st on ct.CountryRegionCode = st.CountryRegionCode;


/*Question 2: Tiếp tục với câu query trước và thêm điều kiện là chỉ lấy country
Germany và Canada
Chú ý: sủ dụng sort order và column headings*/

select ct.name, st.name
from countryregion ct 
join stateprovince st on ct.CountryRegionCode = st.CountryRegionCode
where ct.name = 'Germany' or ct.name = 'Canada';

/*Question 3:
SalesOrderID, OrderDate and SalesPersonID. Từ bảng SalesPerson, chúng ta lấy cột
BusinessEntityID (là định danh của người sales), Bonus and the SalesYTD (là đã sale
được bao nhiêu người trong năm nay)*/

select SalesOrderID, OrderDate, soh.SalesPersonID, sp.SalesPersonID as BusinessEntityID, sp.Bonus, sp.SalesYTD
from salesperson sp
join salesorderheader soh on sp.SalesPersonID = soh.SalesPersonID;


/*Question 4:
Sử dụng câu query ở question 3, thêm cột JobTitle and xóa cột SalesPersonID và
BusinessEntityID.*/

select SalesOrderID, OrderDate, e.Title as JobTitle, sp.Bonus, sp.SalesYTD
from salesperson sp 
join salesorderheader soh on sp.SalesPersonID = soh.SalesPersonID
join employee e using(ContactID); 

