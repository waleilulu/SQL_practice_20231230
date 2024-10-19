 
 
-- Module 17.資料的分群以及彙總函數的使用


-- 補充資料 彙總函式
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/aggregate-functions-transact-sql?view=sql-server-ver15
-- 補充資料 SELECT 陳述式的邏輯處理順序
--https://docs.microsoft.com/zh-tw/sql/t-sql/queries/select-transact-sql?view=sql-server-ver15#logical-processing-order-of-the-select-statement



-- 10. 統計供應商資料表中有幾個供應商？
--		練習 COUNT() 函式
select*from suppliers--29筆
select count (*) from suppliers;--直接想看suppliers有幾個，29筆
select count (supplierID) from suppliers--直接放入想看的欄位也可以

-- 11. count() 是否有統計到 null ?
select count (Region) from suppliers;--得出來是9
select count (distinct Region) from suppliers;--得出來是8，魁北克算一次
select SupplierID, Region from suppliers;--9個地區

→ NULL也換算嗎?
→ NLL沒有計算嗎? 如何知道數字是正確的
select SupplierID, Region from suppliers order by Region desc;--9個地區，20個地區NULL
select distinct Region from suppliers; --剔除掉重複的地區且包含NULL

-- 13. 統計每個地區 (Region)有多少供應商
--    問題：Null 是否會自己形成一個群組？
select region, count(*) from suppliers;--(X) 訊息 8120，層級 16，狀態 1，行 1
資料行 'suppliers.Region' 在選取清單中無效，因為它並未包含在彙總函式或 GROUP BY 子句中。
select region, count(region) from suppliers;--(X) 訊息 8120，層級 16，狀態 1，行 1
資料行 'suppliers.Region' 在選取清單中無效，因為它並未包含在彙總函式或 GROUP BY 子句中。

select region, count(*) from suppliers group by region; --Null 20個，魁北克2個，還有其他地方7個
select region, count(*) 'MyCount' from suppliers where Region is not Null group by region;--這樣NULL那一欄就被隱藏起來了

-- 20. 統計供應商來自那些國家 (Country)
--		透過 group by 語法 分組彙總
select Country, count(*) as '數量' from suppliers group by country

-- 21. 如何針對統計結果篩選，我想要找統計後數量大於1的國家？
select Country, count(*) as '數量' from suppliers where count(*)>1 group by country--(X)訊息 147，層級 15，狀態 1，行 3 除非彙總置於 HAVING 子句或選取清單所包含的子查詢中，且彙總的資料行為外部參考，否則不得在 WHERE 子句中出現。

-- 22. having 是否可以使用欄位別名？
select Country, count(*) as '數量' from suppliers group by country having count(*)>1 --(O)
select Country, count(*) as 數量 from suppliers group by country having 數量>1--(X) 不可用別名

-- SELECT 陳述式的邏輯處理順序
-- 下列步驟顯示 SELECT 陳述式的邏輯處理順序或繫結順序。 此順序會決定在某個步驟中定義的物件提供給後續步驟之子句使用的時間。 例如，如果查詢處理器可繫結至 (存取) FROM 子句中定義的資料表或檢視表，這些物件及其資料行就會提供給所有後續步驟使用。 反之，因為 SELECT 子句是步驟 8，所以前面的子句無法參考該子句中定義的任何資料行別名或衍生資料行。 不過，ORDER BY 子句等後續子句都可以參考它們。 陳述式的實際執行方式由查詢處理器決定，其順序可能與此清單不同。
-- https://learn.microsoft.com/en-us/sql/t-sql/queries/select-transact-sql?view=sql-server-ver15#logical-processing-order-of-the-select-statement

-- FROM
-- ON
-- JOIN
-- WHERE
-- GROUP BY
-- WITH CUBE or WITH ROLLUP
-- HAVING
-- SELECT
-- DISTINCT
-- ORDER BY
-- TOP

-- 25. 統計後如何取得國家數量較多的第一名和第二名?
--		討論 top 數量 、top 數量 .. with ties
select Country, count(*) as '數量' from suppliers group by country having count(*)>1 order by count(*) desc

select top 2 Country, count(*) as '數量' 
from suppliers 
group by country 
having count(*)>1 
order by count(*) desc --USA、France

select top 2 with ties Country, count(*) as '數量' 
from suppliers 
group by country 
having count(*)>1 
order by count(*) desc --USA、France、Germany (平手的都會顯現)

-- 40. 平均值 Avg() 函式 的使用
select AVG(supplierID)
from suppliers
where supplierID in (1,2) --1(整數)

--整數int換成浮點數
換 → 轉型 → cast | convert
select AVG(convert(decimal,supplierID))
from suppliers
where supplierID in (1,2); --1.500000 (浮點數)

SELECT AVG(CAST(supplierID AS DECIMAL))
FROM suppliers
WHERE supplierID IN (1, 2); --1.500000 (浮點數)

select AVG(supplierID * 1.0)
from suppliers --1.500000 (浮點數)

