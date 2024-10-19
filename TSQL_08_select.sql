

-- Module 8.撰寫簡易的 SELECT 查詢語句 


-- 補充資料：SELECT
--https://docs.microsoft.com/zh-tw/sql/t-sql/queries/select-transact-sql?view=sql-server-ver15
-- 補充資料：SQL Server 公用程式陳述式 - GO #Remarks
--https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/sql-server-utilities-statements-go?view=sql-server-ver15#remarks



-- 10. 練習：指定需要使用的資料庫 (use 資料庫名稱)
	USE LAB;--選擇Lab資料庫


-- 20. 觀察 go 指令，請框選底下三行程式碼，觀察結果
	declare @x int = 100
	print @x
	go
	--選擇Lab資料庫

-- 25. 觀察 go 指令，請框選底下四行程式碼，觀察結果
	declare @x int = 5566;
	print @x;
	go       -- go送出了24 & 25 行

	print @x;-- 導致28沒有宣告
	--5566 訊息 137，層級 15，狀態 2，行 5 必須宣告純量變數 "@x"。

	-- ;  > 一個/一行/一列/一段 指令的結束
	-- go > 一群/多行/分批      指令的結束/送出
	-- go 是用來分隔不同的批次的，每個批次中的變數是獨立的。所以在第一個 print @x 後，go 導致了一個新的批次，而這個新批次中沒有宣告過變數 @x，所以出現了錯誤訊息。

-- 30. go 加上數值，表示指令送出前要執行幾次
--     請框選底下這段程式碼，觀察結果 (框選的區間有點大，請確認後再執行)
	use Lab
	go

	-- 創建資料表
	create table TestGO
	(
		mydatetime datetime 
	)
	go
 
	-- 新增資料
	insert into TestGO values(SYSDATETIME())
	go 10 --> go後面接數字，意思為go之前完成10次

	-- 查詢資料表
	select * from TestGO
	--2023-12-12 15:07:01.693
	--2023-12-12 15:07:01.700
	--2023-12-12 15:07:01.703
	--2023-12-12 15:07:01.707
	--2023-12-12 15:07:01.710
	--2023-12-12 15:07:01.713
	--2023-12-12 15:07:01.717
	--2023-12-12 15:07:01.717
	--2023-12-12 15:07:01.720
	--2023-12-12 15:07:01.723
 
	-- 刪除資料表
	drop table TestGO--刪除檔案


-- 40. 一份資料表完整的路徑是：
-- 伺服器名稱.資料庫名稱.資料夾描述.資料表名稱
select * from Shop;--資料庫選擇Lab
select * from dbo.Shop;--資料庫選擇Lab
select * from lab.dbo.Shop;--可以不選資料庫，直接執行。因為指令已經包含資料庫lab了
--以上三種都可以被開啟


select * from DatabaseLog;--資料庫選擇Adventure Works，可被開啟 (因為預設檔案夾就叫做 dbo.)
select * from dbo.DatabaseLog;--資料庫選擇Adventure Works，可被開啟
select * from Address;--資料庫選擇Adventure Works，不能開啟
select * from Person.Address;--資料庫選擇Adventure Works，可被開啟
伺服器名稱=>如果沒有寫，預設值為 SSMS 連線時選擇的伺服器名稱
資料庫名稱=>如果沒有寫，預設值為 左邊工具列下拉選單，手動選擇資料庫
結構/檔案名稱=>如果沒有寫，預設值為 dbo.



-- 50. select 語法結構練習
--查看官方文件
-->得知 select關鍵字可以單獨使用
-->測試 select關鍵字如何單獨使用
Select 1+2; --3
Select GETDATE();--2023-12-12 15:53:17.143
Select SYSDATETIME();--2023-12-12 15:53:35.9227550



-- 55. 以供應商資料表(Suppliers)為例子，練習挑選聯絡資訊等欄位
select * from Suppliers--叫出供應商資料表(Suppliers)
select CompanyName from Suppliers--從供應商資料表(Suppliers)裡，挑選公司這個資料
select CompanyName, ContactName from Suppliers--若要叫出多樣訊息，可以用,區隔



select CompanyName, ContactName, Phone, PostalCode, Country,Region, City, Address from Suppliers


-- 60. 欄位別名，觀察將兩個欄位合併後，查詢結果該欄位是否還有名稱？
--    => 以合併供應商資料表的國家(Country)-城市(City)為例子
select Country, City from Northwind.dbo.Suppliers;--如果有加上資料庫名稱就不用去下拉選單選了
select Country, City from Suppliers;--需要去下拉選單點選資料庫



select Country+' '+City from Northwind.dbo.Suppliers;--沒有資料行名稱

--想要給資料行名稱
select Country+' '+City as 地址 from Northwind.dbo.Suppliers; --地址是自己寫入的名稱，變成資料行地址
select Country+' '+City as '地址' from Northwind.dbo.Suppliers; --地址是自己寫入的名稱，也可以加入字串''
select Country+' '+City  地址 from Northwind.dbo.Suppliers; --地址是自己寫入的名稱，也可以直接省略as

-- 70. 供應商來自那些國家？
--    => 如何取得不重複的清單？
select distinct Country from Northwind.dbo.Suppliers;--加入distinct可以把重複的剃除
select distinct SupplierID from Northwind.dbo.Suppliers;--如果下SupplierID數量還是一樣，因為ID是不一樣

-- 80. 挑選指定的欄位進行資料排序

select distinct SupplierID from Northwind.dbo.Suppliers order by SupplierID；--挑選SupplierID，進行SupplierID的排序



select CompanyName, ContactName, Phone, PostalCode, Country,Region, City, Address from Suppliers
order by Country
--挑選CompanyName, ContactName, Phone, PostalCode, Country,Region, City, Address，用Country來排序



-- 85. SQL分頁寫法，指定資料表回傳的 開始資料列 以及 資料筆數 

SELECT*FROM Suppliers
ORDER BY SupplierID DESC--DESC是反序
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;--從哪裡開始算，開始抓幾列


SELECT*FROM Suppliers
ORDER BY SupplierID--沒有寫就是預設正序
OFFSET 3 ROWS FETCH NEXT 3 ROWS ONLY;--從哪裡開始算，開始抓幾列


