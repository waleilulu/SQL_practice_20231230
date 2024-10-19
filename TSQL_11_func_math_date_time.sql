

-- Module 11.系統內建函數- 數學、日期與時間等函數介紹


-- 補充資料：數學函數 (Transact-SQL)
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver15
-- 補充資料：取得 系統時間日期的範例
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/getdate-transact-sql?view=sql-server-ver15#examples



-- 10. 完整的數學函式庫，請參考上方的補充資料：數學函數 (Transact-SQL)
-- 20. 取得系統時間的範例，請參考補充資料：取得 系統時間日期的範例
SELECT SYSDATETIME()
    ,SYSDATETIMEOFFSET()
    ,SYSUTCDATETIME()
    ,CURRENT_TIMESTAMP
    ,GETDATE()
    ,GETUTCDATE();


-- 21. 請觀察下列兩兩比較，有何異同？
	select SYSDATETIME(), GETDATE();
    select GETDATE(), CURRENT_TIMESTAMP;--注意CURRENT_TIMESTAMP不用加()


-- 22. 透過 Year() 取得系統年
select YEAR(getdate());--2023

-- 23. 透過 Month() 取得系統月份
select Month(getdate());--12


-- 30. 如何取得 北風資料庫中， 7 月份的訂單
select * from [order details]--因為檔名是dbo.Order Details，中間有個空格命名，所以要加[]

select * from orders--830筆
select OrderID, OrderDate from Orders
where month(OrderDate) = 7;--55筆


-- 31. 直接用字串取去比較是否可行？
--     目標: 搜尋 1996年7月10號  到 1996年7月20號 => 預計獲得9筆訂單

-- 方法A: 使用剛剛的函式
Where 條件A and/or 條件B and/or 條件C and/or

select OrderID, OrderDate from Orders
where year(orderdate)=1996 AND month(orderdate)=7 AND day(orderdate) between 10 and 20; --9筆資料

select OrderID, OrderDate from Orders
where year(orderdate)=1996 AND month(orderdate)=7 AND day(orderdate) >=10 AND day(orderdate)<20; --9筆資料

-- 方法B: 其他
select OrderID, OrderDate from Orders
where orderdate between '1996/7/10' and '1996/7/20';--9筆資料

select OrderID, OrderDate from Orders
where orderdate between '1996-7-10' and '1996-7-20';--9筆資料



-- 40. 請透過語法於 Lab 資料庫中建立一個資料表，並寫入今天日期
CREATE TABLE Lab1213 (
    datetime DATETIME
);
INSERT INTO Lab1213 (datetime) VALUES ('2023-12-13');
select*from Lab1213



CREATE TABLE Lab.dbo.Lab11 (
    ID int identity(1, 1) primary key, MyDate datetime2
	);

select*from Lab11
INSERT INTO Lab11 (MyDate) VALUES (getdate());



-- 41. 是否可以透過字串查詢的到今天的日期？ (x)


select*from Lab11
where mydate='2023-12-13'