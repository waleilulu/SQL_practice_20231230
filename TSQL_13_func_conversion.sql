 
 
-- Module 13.系統內建函數- 轉換函數介紹 


-- 補充資料：隱含的轉換對照
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#implicit-conversions
-- 補充資料：時間日期格式對照
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15#date-and-time-styles



-- 10. CAST()、 CONVERT() 以及 PARSE() 轉換的討論和比較
--     CAST ( expression AS data_type [ ( length ) ] ) 
--     CONVERT ( data_type [ ( length ) ] , expression [ , style ] ) 
--     PARSE ( string_value AS data_type [ USING culture ] )  


--		a. 數值的轉換比較
select cast ('123' as int)
select cast (777 as char(3))
select convert(int, '123')

--		b. 日期的轉換比較
select cast(GETDATE() as varchar(100))
select convert(varchar(100), GETDATE())

--		c. PARSE() 可以指定語系
--https://learn.microsoft.com/zh-tw/sql/t-sql/functions/parse-transact-sql?view=sql-server-ver16
SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result;


-- 20. TRY_CAST()、TRY_CONVERT() 以及 TRY_PARSE() 
select convert(int, '5566');--5566
select convert(int, 'apple');--將varchar 值'apple'轉換成資料類型 int時，轉換失敗。
select TRY_CONVERT(int, '8899');--8899
select TRY_CONVERT(int, 'apple');--轉換失敗給null

select supplierID, Postalcode
	,try_convert (int, PostalCode)--先把郵遞區號是整數的撈出來，沒有變整數的就是Null
from Suppliers
where try_convert (int, PostalCode) is null--再把Null挑出來



-- 30. CONVERT() 指定轉換的時間日期格式
20
25
102
111
120

Select CONVERT(varchar(100), GETDATE(), 0)  ; -- 12 31 2024 11:49AM
Select CONVERT(varchar(100), GETDATE(), 1)  ; -- 12/31/22
Select CONVERT(varchar(100), GETDATE(), 2)  ; -- 22.12.31
Select CONVERT(varchar(100), GETDATE(), 3)  ; -- 31/12/22
Select CONVERT(varchar(100), GETDATE(), 4)  ; -- 31.12.22
Select CONVERT(varchar(100), GETDATE(), 5)  ; -- 31-12-22
Select CONVERT(varchar(100), GETDATE(), 6)  ; -- 31 12 22
Select CONVERT(varchar(100), GETDATE(), 7)  ; -- 12 31, 22
Select CONVERT(varchar(100), GETDATE(), 8)  ; -- 11:49:11
Select CONVERT(varchar(100), GETDATE(), 9)  ; -- 12 31 2024 11:49:11:160AM
Select CONVERT(varchar(100), GETDATE(), 10) ; -- 12-31-22
Select CONVERT(varchar(100), GETDATE(), 11) ; -- 22/12/31
Select CONVERT(varchar(100), GETDATE(), 12) ; -- 221231
Select CONVERT(varchar(100), GETDATE(), 13) ; -- 31 12 2024 11:49:11:160
Select CONVERT(varchar(100), GETDATE(), 14) ; -- 11:49:11:160
Select CONVERT(varchar(100), GETDATE(), 20) ; -- 2024-12-31 11:49:11
Select CONVERT(varchar(100), GETDATE(), 21) ; -- 2024-12-31 11:49:11.160
Select CONVERT(varchar(100), GETDATE(), 22) ; -- 12/31/22 11:49:11 AM
Select CONVERT(varchar(100), GETDATE(), 23) ; -- 2024-12-31
Select CONVERT(varchar(100), GETDATE(), 24) ; -- 11:49:11
Select CONVERT(varchar(100), GETDATE(), 25) ; -- 2024-12-31 11:49:11.160
Select CONVERT(varchar(100), GETDATE(), 100); -- 12 31 2024 11:49AM
Select CONVERT(varchar(100), GETDATE(), 101); -- 12/31/2024
Select CONVERT(varchar(100), GETDATE(), 102); -- 2024.12.31
Select CONVERT(varchar(100), GETDATE(), 103); -- 31/12/2024
Select CONVERT(varchar(100), GETDATE(), 104); -- 31.12.2024
Select CONVERT(varchar(100), GETDATE(), 105); -- 31-12-2024
Select CONVERT(varchar(100), GETDATE(), 106); -- 31 12 2024
Select CONVERT(varchar(100), GETDATE(), 107); -- 12 31, 2024
Select CONVERT(varchar(100), GETDATE(), 108); -- 11:49:11
Select CONVERT(varchar(100), GETDATE(), 109); -- 12 31 2024 11:49:11:160AM
Select CONVERT(varchar(100), GETDATE(), 110); -- 12-31-2024
Select CONVERT(varchar(100), GETDATE(), 111); -- 2024/12/31
Select CONVERT(varchar(100), GETDATE(), 112); -- 20241231
Select CONVERT(varchar(100), GETDATE(), 113); -- 31 12 2024 11:49:11:160
Select CONVERT(varchar(100), GETDATE(), 114); -- 11:49:11:160
Select CONVERT(varchar(100), GETDATE(), 120); -- 2024-12-31 11:49:11
Select CONVERT(varchar(100), GETDATE(), 121); -- 2024-12-31 11:49:11.160
Select CONVERT(varchar(100), GETDATE(), 126); -- 2024-12-31T11:49:11.160