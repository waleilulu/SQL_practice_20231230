 
 
-- Module 16.多表格聯結(Join) 的變形查詢語法


-- 10. 我們想要找註冊以後卻從未下過訂單的客戶，進行行銷動作，該如何挑選對應資料？
select*from Customers; --91筆
select distinct customerid from orders; --89筆

1.
select distinct O.customerID as '訂單的', C.CUstomerID as '客戶的' 
from Customers As C
left join orders as O on C.CustomerID=O.CustomerID
where O.customerID is Null
2.
SELECT DISTINCT O.CustomerID AS '訂單的', C.CustomerID AS '客戶的'
FROM Orders AS O
RIGHT JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;

3.
SELECT *
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- 20. "假設" 北風資料庫中，產品資料表(Products) 和 產品類別資料表(Categories) 目前沒有關聯
--		如果每一個產品類別都包含所有於產品資料表的品項，該如何得到這樣的資料?

--A表的資料 跟 B表的資料相乘 → 庫存
--黑色衣服      XL
--襯衫          L
--外套          M
insert into (黑, XL)
insert into (黑, L)
insert into (黑, M)

select * from products;--77筆
select * from Categories;--8筆
select * from Products cross join Categories;--77**=616筆

-- 30. 觀察 Employees 資料表可以知道，員工的主管也包含在其中；
--		請幫忙整理出員工以及員工的主管姓名
--self join

select * from Employees

select EmployeeID, FirstName, ReportsTo from Employees; --A資料
select EmployeeID, FirstName,           from Employees; --B資料
--決定ON: A.reportsto B.EmployeeID

--拚起來
select A.EmployeeID, A.FirstName, A.ReportsTo, ISNULL(B.FirstName, A.FirstName) 
from Employees A
left join Employees B on A.reportsto = B.employeeID;



