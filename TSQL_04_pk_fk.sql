

-- Module 4.使用Keys條件約束(Constraints)來實作資料的完整性 


-- 補充資料：建立主索引鍵
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/create-primary-keys?view=sql-server-ver15
-- 補充資料：建立外部索引鍵關聯性
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/create-foreign-key-relationships?view=sql-server-ver15
-- 補充資料：UNIQUE 條件約束 
--https://docs.microsoft.com/zh-tw/sql/relational-databases/tables/unique-constraints-and-check-constraints?view=sql-server-ver15#Unique



-- 10. 定義 primary key 主索引鍵 / PK / 主鍵 (需要一個當PK值去取得其他列的資料)
-- primary key 主索引鍵: 每一個資料表都要有一個資料行，資料行裡面有一個東西是不會改也不能改的東西，把它設置成primary key 主索引鍵
-- 隱私性的資料也不能當primary key 主索引鍵，像是身份證字號、手機電話號碼

-- 目標：設定 shop_employee 和 shop 這兩張資料表的 primary key 
--
--	    方法a. Shop 資料表設計介面> 選擇 店鋪代號 欄位> (上方工具列) 設定主索引鍵
--	    方法b. Shop 資料表設計介面> 選擇 店鋪代號 欄位> 右鍵> 設定主索引鍵
CREATE TABLE 學生 (
    學生ID INT PRIMARY KEY,
    姓名 VARCHAR(50),
    年齡 INT,
    地址 VARCHAR(100)
);



-- 20. 定義 foreign key / 外鍵 / 外部索引鍵 / 外鍵 (兩個資料表有關聯的時候，需要設定PK 像是shopID)
--
-- 目標：設定 shop_employee 資料表的 foreign key 
--
--      ShopEmployee 資料表設計介面> 任意處> 右鍵
--          > 關聯性> 加入(按鈕)> 一般/資料表及資料行規格 (選單展開)> ...(按鈕)
--          > 關聯性名稱: 預設為 FK_資料表_資料表可以依照需求進行修改
--          > 主索引鍵資料表> 下拉> 找到 Shop> 下方空白處點一下> 下拉> 找到店鋪代號欄位
--          > 外部索引鍵資料表> 固定 ShopEmployee> 下方空白處點一下> 下拉> 找到店鋪代號欄位
--          > 確定(按鈕)> 回到 外部索引鍵關聯性> 關閉(按鈕)
--          > 於 ShopEmployee 資料表設計介面 進行上述步驟存檔
CREATE TABLE 客戶 (
    客戶ID INT PRIMARY KEY,
    姓名 VARCHAR(50),
    電子郵件 VARCHAR(255)
);

CREATE TABLE 訂單 (
    訂單ID INT PRIMARY KEY,
    產品名稱 VARCHAR(100),
    金額 DECIMAL(10, 2),
    客戶ID INT,
    FOREIGN KEY (客戶ID)
);



-- 30. 不允許出現重複值 UNIQUE
--
-- 目標：「假設」員工的 手機號碼 不允許重複，幼稚園的小朋友緊急連絡人電話會重複
-- 
--      ShopEmployee 資料表設計介面> 任意處> 右鍵
--          > 索引/索引鍵 > 加入(按鈕) 
--          > 一般/型別  > (下拉) 唯一索引鍵  
--          > 一般/資料行> 選擇 手機號碼 欄位> 關閉(按鈕)
--          > 於 ShopEmployee 資料表設計介面 進行上述步驟存檔
CREATE TABLE 用戶 (
    用戶ID INT PRIMARY KEY, --用戶ID設為PK
    電子郵件 VARCHAR(255) UNIQUE,--想是電子郵件這邊，不允許有重複的
    姓名 VARCHAR(50)
);




