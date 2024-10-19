-- ** 請練習撰寫底下指令 ** 

-- 300 確定打開的是 Northwind 資料庫 
Northwind
go


-- 310 列出 以下欄位 ProductID, ProductName, SupplierID
select * from Products
select ProductID, ProductName, SupplierID from Products

-- 315 延續上題 310
--     請帶出該產品的供應商公司名稱(CompanyName)、聯絡電話(Phone)、聯絡人(ContactName)
--     相同供應商的資料(SupplierID)請列在一起
-- 12/28
SELECT p.ProductID, p.ProductName, s.CompanyName, s. Phone, s. ContactName, s.contacttitle 
FROM Products p
left join suppliers s on p.SupplierID = s.SupplierID
order by CompanyName







--SQL A(Products):  select ProductID, ProductName, SupplierID from Products
--SQL B(Suppliers): select SupplierID, CompanyName, Phone, ContactName from Suppliers
--on: products.SupplierID=suppliers.SupplierID (兩個表格要參照的依據是SupplierID)
--join:

SELECT p.ProductID, p.ProductName, p.SupplierID
FROM Products p
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID;--老師範例

SELECT Products.ProductID, Products.ProductName, Products.SupplierID -- SQL A(Products)是要留下的
FROM Products -- SQL A(Products)是要留下的
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;--lfet join加入SQL B(Suppliers)帶來的資料
--也可以寫成這樣，不用縮寫

select ProductID, ProductName, SupplierID from Products--(X)模稜兩可的資料行名稱 'SupplierID'，因為SupplierID存在於兩個SQL，必須指明是誰的。
left join Suppliers on Products.SupplierID=Suppliers.SupplierID 
select ProductID, ProductName, Products.SupplierID from Products--(O)需寫成Products.SupplierID，其餘沒有交集的欄位可以省略不寫Products.
left join Suppliers on Products.SupplierID=Suppliers.SupplierID


-- 320 延續上題 310
--     請加入條件："庫存量低於再訂購量" 的產品資料
-- 12/28
SELECT p.ProductID, p.ProductName,
s.CompanyName, s. Phone, s. ContactName, s.contacttitle 
,p.ReorderLevel-(p.unitsinstock + p. UnitsOnOrder)
,p. ReorderLevel, p.UnitPrice
FROM Products p
left join suppliers s on p.SupplierID = s.SupplierID
where p.unitsinstock + p. UnitsOnOrder < p.ReorderLevel
order by s.SupplierID








SELECT p.ProductID, p.ProductName, p.SupplierID
FROM Products p
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
where p. unitsinstock + p.UnitsOnOrder<p.ReorderLevel


select * from Products
where productID in (30, 70) 

-- 340. 哪張訂單的總金額最高？ -> sum()
-- 12/28
select top 1 od.orderID, sum(od.UnitPrice * od.Quantity*(1-Discount)) as Total
from [order details] od
group by od.orderID
order by Total desc

-- 也可寫成以下
select top 1 od.orderID, sum(od.UnitPrice * od.Quantity*(1-Discount)) as Total
from [order details] od
group by od.orderID
order by sum(od.UnitPrice * od.Quantity*(1-Discount)) desc








select*from [order details]

SELECT orderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalAmount --列出所有訂單金額
FROM [order details]
GROUP BY orderID
ORDER BY TotalAmount DESC --由多排序到少


SELECT top 1 orderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalAmount --用top1意思指取最高
FROM [order details]
GROUP BY orderID
ORDER BY TotalAmount DESC


-- 350. 總共有幾位業務負責處理VINET的訂單？ (顯示總數) 
select * from Orders
order by CustomerID--找到有EmployeeID: 2、3、5、6 (4位)

-- 12/28
-- 方法A
select *from orders O
where o.CustomerID='VINET'

select count (distinct o.EmployeeID) from orders O
where o.CustomerID='VINET'

-- 方法B->where select->from
select * from (select distinct o.EmployeeID from orders O
where o.CustomerID='VINET') apple

select count(*)
from (select distinct o.EmployeeID from orders O
where o.CustomerID='VINET') apple


-- 360. 負責處理VINET的訂單是哪些業務？
select o.orderID, o.CustomerID, e.firstname, e.lastname 
from orders O
inner join Employees e on o.EmployeeID = e.EmployeeID
where o.CustomerID='VINET'


select distinct e.firstname, e.lastname, e.extension 
from orders O
inner join Employees e on o.EmployeeID = e.EmployeeID
where o.CustomerID='VINET'

-- 370. 有哪些產品是日商提供的？
-- 方法A:子查詢
select * from Suppliers s where s.country = 'Japan'

select s. supplierID from Suppliers s 
where s.country = 'Japan'

select * from Products
where supplierID in (4,6)

select * from Products
where supplierID in (select s. supplierID from Suppliers s 
where s.country = 'Japan')
-- 方法B
select * 
from Products p
inner join suppliers s on p.supplierID=s.supplierID
where s.country = 'Japan'



select * from Suppliers s

