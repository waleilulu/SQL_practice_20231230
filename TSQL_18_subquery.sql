

-- Module 18.子查詢(Subquery) 的運用



-- 10. 目前訂單編號 10847 中 有六個產品編號 1,19,37,45,60,71
--    a. 透過 in (..) 的方式，在產品資料表中取得產品資料
select * from [order details] where orderID=10847


select* from Products
where productID in (1,19,37,45,60,71);

--	  b. 改以透過 子查詢 的方式，在產品資料表中取得產品資料
select productID from [order details] where orderID=10847
--將上方插入至小括號裡，select * from Products where productID in ()
select * from Products where productID in (select productID from [order details] where orderID=10847);

-- 20. 產品資料表中，所有產品的平均單價為何？
select ProductID, UnitPrice from Products
select AVG(UnitPrice) from Products--28.8663


-- 21. 如何得知每一項產品與平均單價差異多少？ 
ALTER TABLE Products ADD AVG DECIMAL (6,4)
UPDATE Products
SET AVG = 28.8663;
select ProductID, UnitPrice, AVG from Products
select ProductID
	, UnitPrice
	, AVG 
	,(AVG-UnitPrice) as '單價差異'
	from Products


-- 30. 檢查是否所有訂單的產品編號都來自產品資料表中？
--     a. 製作測試資料
Create Table Lab181 ( ProductID int );
Create Table Lab182 ( OrderID char(1),  ProductID int);

insert into  Lab181 (ProductID) values (1);
insert into  Lab181 (ProductID) values (2);
insert into  Lab181 (ProductID) values (3);

insert into  Lab182 (OrderID, ProductID) values ('A', 1);
insert into  Lab182 (OrderID, ProductID) values ('B', 98);
insert into  Lab182 (OrderID, ProductID) values ('C', 99);

select * from Lab181;
select * from Lab182;

--     b. 嘗試透過底下關鍵字，找出異常訂單： B 、 C
--          join、subquery、其他

--join
SELECT Lab182.OrderID, Lab182.ProductID
FROM Lab182
LEFT JOIN Lab181 ON Lab182.ProductID = Lab181.ProductID
WHERE Lab182.OrderID IN ('B', 'C') AND Lab181.ProductID IS NULL;--找出B跟C



select o.OrderID
    ,o. productID as '訂單的產品編號'
    ,p. productID as '產品的產品編號'
from Lab182 o
left join Lab181 p
on o.productID=p.productID
where p.productID is null



--subquery子查詢
select * from Lab182 where orderID in ('B', 'C') 
and 
productID in (select * from Lab181)