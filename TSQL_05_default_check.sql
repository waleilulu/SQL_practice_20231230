

-- Module 5.使用一般的條件約束(Constraints)來實作資料的完整性 


-- 補充資料：指定資料行的預設值
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/specify-default-values-for-columns?view=sql-server-2017
-- 補充資料：建立檢查條件約束
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/create-check-constraints?view=sql-server-ver15
-- 補充資料：資料表層級條件約束 table-constraint
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/alter-table-table-constraint-transact-sql?view=sql-server-ver15
-- 補充資料：欄位層級條件約束 column-constraint
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/alter-table-column-constraint-transact-sql?view=sql-server-ver15
-- 補充資料：Unicode 字串
--https://docs.microsoft.com/zh-tw/sql/t-sql/data-types/constants-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15#unicode-strings



-- 10. 定義欄位的預設值
--
-- 目標：當飲料店店鋪名稱沒有輸入，給預設值文字
-- 
--     Shop 資料表設計介面> 選擇 店鋪名稱 欄位> (下方)資料行屬性> 預設值或繫結> 輸入 小叮噹



-- 15. 透過語法撰寫預設值，請參考上方的補充資料：指定資料行的預設值
--		除了透過介面以外，也可以透過語法設定
-- 補充資料：指定資料行的預設值
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/specify-default-values-for-columns?view=sql-server-2017
ALTER TABLE Shop
  ADD CONSTRAINT DF_Apple
  DEFAULT '台中市' FOR ShopAddress;

  CREATE TABLE -->建立新表格
  ALTER TABLE   -->修改表格內容


-- 20. 資料寫入前的檢查
--	   「假設」 店鋪資本額 必須要大於 0
--     Shop 資料表設計介面> 任意處> 右鍵> 檢查條件約束> 加入(按鈕)
--         > 一般/運算式 > 輸入 店鋪資本額 > 0



-- 25. 透過語法撰寫檢查，請參考上方的補充資料：建立檢查條件約束
--		除了透過介面以外，也可以透過語法設定

--沒有給檢查約束條件名稱->會有預設值
ALTER TABLE 表格名稱
ADD CONSTRAINT 約束名稱 CHECK (條件);
--表格名稱 是你想要添加約束的資料表名稱，約束名稱 是你為這個 CHECK 約束指定的名稱（可選），而 條件 是你希望資料表中的數值滿足的條件。

ALTER TABLE Shop
ADD CHECK (ShopCapital>=0);

--設定(給)檢查約束條件 的名稱
ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes');


