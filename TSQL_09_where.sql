 

-- Module 9.基本資料的查詢與篩選


-- 補充資料：運算子優先順序
--https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/operator-precedence-transact-sql?view=sql-server-ver15



-- 10. 請挑選國家(Country)來自日本(Japan)的供應商
--		討論有單引號和沒有單引號的差異
SELECT SupplierID, Country FROM Suppliers
Where Country=Japan --(x)訊息 207，層級 16，狀態 1，行 2 無效的資料行名稱 'Japan'，

SELECT SupplierID, Country FROM Suppliers
Where Country='Japan' (o)--Japan是一個字串值需要加上單引號



-- 15. 請挑選 ContactTitle = 'Sales Manager' 
--     且國家來自 'France' 或者 'Germany'
--     的供應商資料

公式
select 資料行 from 資料表 where 資料行 = 資料值
select 資料行 from 資料表 where 資料行 Like %資料值%
select 資料行 from 資料表 where 資料行 between 整數 and 整數
select 資料行 from 資料表 where 資料行 in (資料值, 資料值,...)
select 資料行 from 資料表 where 資料行 is Null --不是=null


select SupplierID, ContactTitle, Country from Suppliers
where ContactTitle = 'Sales Manager'--11, 18, 21, 27


select SupplierID, ContactTitle, Country from Suppliers
where Country = 'France'--18, 27, 28

select SupplierID, ContactTitle, Country from Suppliers
where Country = 'Germany'--11, 12, 13


select SupplierID, ContactTitle, Country from Suppliers
where (ContactTitle = 'Sales Manager') and (Country='France' OR Country='Germany')--正解，11,18, 27,


-- 20. 練習使用 like 搜尋資料
--		只知道資料的部分內容時，可以透過 like 進行模糊比對

例子: select from 資展學生 where 學生姓名 like '%雅婷'--雅婷前面被模糊掉了，只要找雅婷結尾的。

資料行 LIKE '%a'
select SupplierID, Country from Suppliers
Where Country like '%a' -- A結尾，USA、USA、Australia、USA、USA、Australia、Canada、Canada

資料行 LIKE '%a%'
select SupplierID, Country from Suppliers
Where Country like '%a%' -- 中間包含A


資料行 LIKE 'a%'
select SupplierID, Country from Suppliers
Where Country like 'a%' -- A開頭


-- 25. 練習使用區間的範圍取得：供應商編號介於 3 到 7 之間的
--		between .. and 
select SupplierID, Country from Suppliers
Where SupplierID between 3 and 7--連續區間可以用between...and...


-- 29. 練習搜尋同一資料行中的多重值：供應商城市在大阪(Osaka)或東京(Tokyo)
--      in (...)
select SupplierID, City from Suppliers
Where City in ('Osaka', 'Tokyo')

select SupplierID, City from Suppliers
Where City = ('Osaka') or City = ('Tokyo')

select SupplierID, City from Suppliers
Where City = 'Osaka' or City = 'Tokyo'


-- 30. 試著挑選出 Lab061 資料表中
--      包含 凃 的資料

select * from Lab061 where c ='蘋果'
select * from Lab061 where c ='凃'

