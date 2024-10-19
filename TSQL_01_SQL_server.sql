

-- Module 1.關聯式資料庫的基本概念與 SQL Server 簡介


-- 補充資料：結構化查詢語言 (SQL) (Structured Query Language (SQL))
--https://docs.microsoft.com/zh-tw/sql/odbc/reference/structured-query-language-sql?view=sql-server-ver15
-- 補充資料：DML, DDL, DCL, TCL
--https://social.technet.microsoft.com/wiki/contents/articles/34477.sql-server-commands-dml-ddl-dcl-tcl.aspx
-- 補充資料：使用 SQL Server Management Studio (SSMS) 連線至 SQL Server 執行個體並進行查詢
--https://docs.microsoft.com/zh-tw/sql/ssms/tutorials/connect-query-sql-server?view=sql-server-ver15



-- 環境設定：
-- . 工具 → 選項 → 環境 → 字型和色彩 → 字型
-- . 工具 → 選項 → 環境 → 字型和色彩 → 大小
-- . 工具 → 選項 → 文字編輯器 → Transact-SQL → 行號
-- . 檢視 → 物件總管



-- 匯入微軟官方所提供的資料庫
--   A. Northwind：請依照底下步驟進行
--      1. 在 SSMS 管理介面開啟 instnwnd.sql
--		2. 手動新增 Northwind (北風資料庫)
--		3. 點選執行



--   B. AdventureWorksDW2022：請依照底下文件進行
--      將 .bak 範例資料庫還原至 SQL Server ：
--      https://docs.microsoft.com/zh-tw/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms#restore-to-sql-server



--   C. AdventureWorks：請依照底下步驟進行
--		1. 底下全部的檔案放到 C:\Samples\AdventureWorks
--		2. 在 C:\Samples\AdventureWorks 資料夾內找到 instawdb.sql 
--      3. 在 SSMS 管理介面開啟 instawdb.sql 
--		4. SSMS 管理介面點選 查詢 > SQLCMD 模式
--		5. 點選執行
--		   * 會有一些警告|錯誤，若確認資料表有資料，則暫時無須理會
