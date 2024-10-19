-- ** 請練習撰寫底下指令 **
-- ** 使用 Products 產品資料表 ** 
-- ** 請確認打開的是 Northwind 資料庫 ** 



-- 110 挑選 所有 產品資料
select * from Products;


-- 115 挑選 所有 產品資料，並用產品名稱排序
select * from Products
order by ProductName;


-- 120 挑選 指定欄位：ProductID, ProductName, UnitPrice
select ProductID, ProductName, UnitPrice
from Products;


-- 125 延續上題，請將欄位名稱改成以中文 產品編號, 產品名稱, 單價 顯示，以下選一種
select ProductID as 產品編號, ProductName as 產品名稱, UnitPrice as 單價
from Products;

或是

select ProductID as '產品編號', ProductName as '產品名稱', UnitPrice as '單價'
from Products;

或是

select ProductID  產品編號, ProductName  產品名稱, UnitPrice  單價
from Products;


-- 130 挑選 庫存量低於再訂購量 的產品資料，並挑選欄位
--     ProductID, ProductName, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
select ProductID, ProductName, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
from Products
where UnitsInStock < ReorderLevel;

select * from Products as p where p.UnitsInStock < p.ReorderLevel;



-- 140 挑選 (庫存量+在途數)低於再訂購量 的產品資料，並挑選欄位：
--     ProductID, ProductName, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
select ProductID, ProductName, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
from Products
where (UnitsInStock + UnitsOnOrder) < ReorderLevel;

select * from Products as p where (p.UnitsInStock + p.UnitsOnOrder) < p.ReorderLevel;



-- 150 挑選 產品名稱 包含 ku 的資料
select ProductName
from Products
where ProductName LIKE '%ku%';


-- 160 挑選 類別編號 (CategoryID) 為 1, 4, 8 的產品資料
--     並依照 類別編號 和 產品名稱 排序
select CategoryID, ProductName
from Products
where CategoryID in (1, 4, 8)
order by CategoryID, ProductName;


-- 170 挑選 單價 介於 15 到 20 元之間(包含 15, 20)的產品資料
--     並且按照 單價 由大到小排序
select UnitPrice, ProductName
from Products
where UnitPrice>15 and UnitPrice<20 
order by UnitPrice; 

