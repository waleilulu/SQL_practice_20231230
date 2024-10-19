

-- Module 3.資料表(Tables)的基礎觀念、設計與實作 


-- 補充資料：CREATE TABLE
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/create-table-transact-sql?view=sql-server-ver15
-- 補充資料：Transact-SQL 語法慣例
--https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/transact-sql-syntax-conventions-transact-sql?view=sql-server-ver15



-- 10. 建立資料庫
-- --		a. 資料庫節點，右鍵新增資料庫
-- --		b. 輸入資料庫名稱 Lab， Create Database 資料庫名稱->Create Table 資料表名稱(
--    欄位名稱 資料型態, 
--    欄位名稱 資料型態,
--    欄位名稱 資料型態
-- );

-- 在SQL裡面大小寫沒有差別


   




-- 20. 試著透過指令，建立飲料店資料表 shop
--https://docs.google.com/spreadsheets/d/1D7rKdq68MS7asOiTjCFHuyO6ahM9ixJvc1nF8js5kAg/edit#gid=185744545
CREATE TABLE Shop(
   ShopID INT,
    ShopName VARCHAR(5),
     ShopPhone CHAR(10),
     ShopAddress VARCHAR(250),
     ShopCapital INT
);


-- 30. 試著透過介面，建立飲料店員工資料表 ShopEmployee
--		a. 在物件總管展開 Lab 資料庫的節點
--		b. 找到 「資料表」節點，點選滑鼠右鍵出現新增選單，在點選選單上的「資料表」
-- 屬標放在資料庫上，右鍵新增資料庫。



-- 31. 透過介面，設定「識別規格」
--     dbo.ShopEmployee > 右鍵 > 設計
--     選擇 員工編號 欄位 > 「識別規格」 > 觀察「允許null」取消勾選



-- 32. 透過介面產生 create 指令碼
--     dbo.ShopEmployee > 右鍵 > 編寫資料表的指令碼為 > Create至 > 新增查詢編輯視窗 
--     觀察上一個步驟透過介面的設定，產生出來的指令是那些
CREATE TABLE [dbo].[ShopEmployee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,-- 不可以是空的
	[EmpName] [varchar](26) NULL,
	[EmpPhone] [char](10) NULL,
	[ShopID] [int] NULL
) ON [PRIMARY]--預設

--IDENTITY(1,1)，意思是從一開始排序，+1為下一號。

-- 40. SQL Server 2008 起預設的設定，資料表新增以後不允許直接透過介面修改
--		工具 > 選項 > 設計師(designers) > 取消「防止儲存需要資料表重建的變更」 > 再重新開啟


