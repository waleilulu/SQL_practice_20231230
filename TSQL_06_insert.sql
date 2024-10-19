

-- Module 6.DML指令的使用──如何做資料的新增 


-- 補充資料：INSERT
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/insert-transact-sql?view=sql-server-ver15
-- 補充資料：SET DATEFORMAT
--https://docs.microsoft.com/zh-tw/sql/t-sql/data-types/date-transact-sql?view=sql-server-ver15
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/set-dateformat-transact-sql?view=sql-server-ver15

ALTER：修改資料表結構
ALTER TABLE 學生
ADD COLUMN 生日 DATE;
在 學生 表格中添加了一個名為 生日 的新欄位。


INSERT：插入資料
INSERT INTO 學生 (學生ID, 姓名, 年齡, 生日)
VALUES (1, '小明', 20, '2003-01-15');
將一條新的學生資料插入到 學生 表格中。



-- 10. 透過語法建立資料表
--		確認所選取的資料庫為 Lab 後，框選底下程式碼直接執行
create table Lab06
(							(起始, 間隔/區間/累進)
	ProductID int identity (1,3) NOT NULL,--NOT NULL表示不能是空值
	Price int NULL--NULL 可以接受空值
);

select * from Lab06;--確認所選取的資料庫為 Lab


-- 11. 透過語法新增資料，當資料欄位被定義為 identity，是否能再透過指令新增? 不行(X)
--公式: 
INSERT INTO 資料表名稱 (欄位的名稱1, 欄位的名稱2, ) VALUES (欄位的值1, 欄位的值2, )

INSERT INTO Lab06 (ProductID, Price) VALUES (100, 200)--不行(X)
INSERT INTO Lab06 (Price) VALUES (200)--可以(o)


-- 12. 透過語法新增一筆價格為 200 的資料，觀察 ProductID
INSERT INTO Lab06 (Price) VALUES (200)--可以(o)
select * from Lab06;--進行查看


-- 13. 再新增一筆價格為 123 的資料後，該筆資料的流水號為多少？
==>因為Prouduct ID 設為 identity (1, 3)--第一個為1，第二個為1+3=4，進行編號
所以號碼會是 1, 4, 7, 10 .....進行編號



-- 20. 建立資料表與部分資料後，如何透過語法增加欄位？ 
--      例如增加新增日期 CreateDate
ALTER TABLE Lab06 
ADD CreateDate DATETIME2; 
select * from Lab06;--輸入完案執行，成功後再輸入 
會看到新增了一欄CreateDate


DATETIME跟DATETIME2差別
DATETIME: 時間範圍為 "00:00:00.000" 到 "23:59:59.997"
DATETIME2 較精確: 時間範圍為 "00:00:00.0000000" 到 "23:59:59.9999999"

-- 21. 增加以後再重新撈資料庫的資料，剛剛那兩筆資料的 CreateDate 會有資料出現嗎? 



-- 22. 再追加一個有預設值的欄位，例如異動時間 UpdateDate
--		這樣一來，先前的資料會有資料出現嗎？
ALTER TABLE Lab06 ADD UpdateDate DATETIME2 DEFAULT GETDATE();
select * from Lab06;


--=> DEFAULT: 當新增(insert)沒有給值的時候，系統會把預設值放進去
INSERT INTO Lab06 (Price, CreateDate, UpdateDate) VALUES (12345, GETDATE(), GETDATE());
select * from Lab06;


INSERT INTO Lab06 (Price) VALUES (6789);
select * from Lab06;

--(以上可以分兩個視窗，一個執行輸入，一個查看)

-- 28. 新增時若欄位順序沒有一致，是否會引發錯誤訊息？
INSERT INTO Lab06 (Price, CreateDate) VALUES (GETDATE(), 123);--錯誤訊息，不允許從資料類型 datetime 隱含轉換到 int。請使用 CONVERT 函數來執行查詢。


	create table TestGO
	(
		mydatetime datetime --->要跟下面的SYSDATETIME()型態符合。ex: price 要對數字
	)
	go
 
	insert into TestGO values(SYSDATETIME())
	go 10


-- 30. 透過語法新增一筆價格為 666 的資料，觀察這筆資料的流水號是多少
INSERT INTO Lab06 (Price) VALUES (666);
select * from Lab06; -- 16號


-- 31. 若 30 有執行成功，請預測底下資料新增後的流水號是什麼？
insert into Lab06 (Price) values (130);  
select * from Lab06;-- 19號

-- 32. 若 31 有執行成功，請預測底下資料新增後的流水號是什麼？
insert into Lab06 (Price) values ('abc');
select * from Lab06;--沒寫入成功，但會計算輸入的序號(像銀行抽號碼牌，沒辦成功但有抽號碼牌)

-- 33. 如果 32 沒有執行成功，那底下資料新增後的流水號是什麼？
insert into Lab06 (Price) values (160);   
select * from Lab06;-- 25號


-- 50. insert 語法介紹完畢後，請練習寫入 Shop 和 ShopEmployee
--   * 觀察資料寫入時 PK、FK、default、check 等設定如何發揮影響

insert into ShopEmployee(EmpID, EmpName, EmpPhone, ShopID)values(1, '皮卡丘','0911111111', 1)
-- (X) 訊息 544，層級 16，狀態 1，行 1 當 IDENTITY_INSERT 設為 OFF 時，無法將外顯值插入資料表 'ShopEmployee' 的識別欄位中。
-- 透過觀察EmpID被設定成IDENTITY(識別)，所以不能給值

insert into ShopEmployee(EmpName, EmpPhone, ShopID)values('皮卡丘','0911222333', 1)
--(X) 訊息 547，層級 16，狀態 0，行 1INSERT 陳述式與 FOREIGN KEY 條件約束 "FK_ShopEmployee_Shop" 衝突。衝突發生在資料庫 "Lab"，資料表 "dbo.Shop", column 'ShopID'。陳述式已經結束。
--因為Shop 資料表不存在ShopID 為1的資料


改為先輸入員工名稱跟員工電話
insert into ShopEmployee(EmpName, EmpPhone)values('皮卡丘','0911222333')
select*from ShopEmployee
--(o)輸入成功

insert into ShopEmployee(EmpName, EmpPhone)values('胖丁','0911222333')
insert into ShopEmployee(EmpName, EmpPhone)values('超夢','0911222333')
--(X)訊息 2627，層級 14，狀態 1，行 1 違反 UNIQUE KEY 條件約束 'IX_ShopEmployee'。無法在物件 'dbo.ShopEmployee' 中插入重複的索引鍵。重複的索引鍵值是 (0911222333)。陳述式已經結束。訊息 2627，層級 14，狀態 1，行 2違反 UNIQUE KEY 條件約束 'IX_ShopEmployee'。無法在物件 'dbo.ShopEmployee' 中插入重複的索引鍵。重複的索引鍵值是 (0911222333)。陳述式已經結束。
--手機號不能一樣

insert into ShopEmployee(EmpName, EmpPhone)values('胖丁','0911222335')
insert into ShopEmployee(EmpName, EmpPhone)values('超夢','0911222339')
select*from ShopEmployee
--(o)輸入成功


dbo.Shop>右鍵>編寫資料表的指令碼為>Create至>新增查詢編輯器視窗
insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(1,'','', '',0)
select*from Shop
--(o)輸入成功

insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(2,'店店','', '',0)
select*from Shop
--(o)輸入成功

insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(3,'店店','0422225555', '',0)
select*from Shop
--(o)輸入成功

insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(4,'店店','0422225555', '台中市南屯區公益路300號',0)
select*from Shop
--(o)輸入成功

insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(5,'店店','0422225555', '台中市南屯區公益路300號',500000)
select*from Shop
--(o)輸入成功

insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(6,'唐吉訶德高雄店','0422225555', '台中市南屯區公益路300號',500000)
--(X) 訊息 2628，層級 16，狀態 1，行 1 資料表 'Lab.dbo.Shop'，資料行 'ShopName' 中的字串或二進位資料將會截斷。截斷的值: '唐吉'。陳述式已經結束。
--字串數字不夠所以被剪斷，dbo.Shop>右鍵>設計>varchar(5)>把()裡面的數字調大varchar(50)>是
重新執行
insert into shop(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)values(6,'唐吉訶德高雄店','0422225555', '台中市南屯區公益路300號',500000)
select*from Shop
--(o)輸入成功

--省略不寫前面的(ShopID,ShopName, ShopPhone, ShopAddress, ShopCapital)也可以，但如果省略不寫欄位名稱，則必須提供所有欄位的值，並且值的順序必須與資料表中欄位的順序相符。
insert into shop values(7,'唐吉訶德高雄二店','0422225555', '台中市南屯區公益路300號',500000)
select*from Shop
--(o)輸入成功


剛剛前面Shop 資料表不存在ShopID 為1的資料，現在shopID建起來了，把員工資料加入shopID店號
insert into ShopEmployee(EmpName, EmpPhone, ShopID)values('皮卡丘','0911222333', 1)
--(X) 因為電話跟前面已數入的建檔資料重複了

insert into ShopEmployee(EmpName, EmpPhone, ShopID)values('皮卡丘','0911222666', 1)
select*from ShopEmployee
--(o)輸入成功

"/*
	2023.12.12 AM

	02 data type: 資料型態 int char varchar datetime2
	
	03 create table: 公式要背
	Create table 給個table名稱 (
	ID INT IDENTITY(1,1),
    Name NVARCHAR(255),
	Phone INT (30),
    Address NVARCHAR(255)
	);

	04 pk fk UNIQUE: 
		PK     一定要有
		FK     不一定
		UNIQUE 不一定

	05 default check:
		default: 預設值 ， insert 沒有給
		  check: 檢查 ， insert 去檢查

	針對資料表進行各式各樣的「設定」
	--------------------
	06_insert: 寫入資料
*/"


-- 60. 比較 char、nchar、varchar、nvarchar 的差異
--  a. 新增一個資料表， 該資料表需包含 5 個欄位
--	   ==> 第一個欄位 設定自動編號
--     ==> 其他四個欄位包含 char、nchar、varchar、nvarchar 四種類型的欄位
--         四個欄位長度各自設定為 10
CREATE TABLE Lab061(
	ID INT IDENTITY(1,1), --> 設定自動編號
	C  CHAR(10), --定義了一個固定長度為 10 的字符列。如果存儲的字符串不足 10 個字符，會用空格進行填充。
	NC NCHAR(10), -- 定義了一個固定長度為 10 的 Unicode 字符串列。但用於存儲 Unicode 字符集（例如，中文、日文等）的字符。
	V  VARCHAR(10), --定義了一個最大長度為 10 的可變字符列。存儲的實際數據不會填充到最大長度，只占據實際字符數的存儲空間。
	NV NVARCHAR(10) --定義了一個最大長度為 10 的 Unicode 字符串列。但用於存儲 Unicode 字符集（例如，中文、日文等）的字符。
)


--	b. 新增一筆紀錄，4個欄位分別都輸入：'蘋果'
INSERT INTO Lab061(C, NC, V, NV)VALUES('蘋果','蘋果','蘋果','蘋果');
--(o)輸入成功 1	蘋果      	蘋果        	蘋果	蘋果

--	c. 新增一筆紀錄，4個欄位分別都輸入：'凃'
INSERT INTO Lab061(C, NC, V, NV)VALUES('凃','凃','凃','凃');
--(?)出現亂碼 2	?         	?         	?	?


--	d. 新增一筆紀錄，4個欄位分別都輸入：N'凃'
INSERT INTO Lab061(C, NC, V, NV)VALUES(N'凃',N'凃',N'凃',N'凃');
--(?)出現亂碼 3	?         	凃         	?	凃


--	e. 新增一筆紀錄，4個欄位分別都輸入：'堃'
INSERT INTO Lab061(C, NC, V, NV)VALUES('堃','堃','堃','堃');
--(?)出現亂碼 4	?         	?         	?	?

--  f. 挑選 Lab061 資料表

--12/15考試最後一題，透過語法建立飲料店「菜單」資料表，並透過語法寫入一筆資料到菜單資料表
create table ShopMenu (
	ID int identity (1, 1) primary key,
	drinkname varchar (50),
	drinkprice int,
	drinksize varchar(2)
)

insert into ShopMenu (drinkname, drinkprice, drinksize)
values ('珍珠奶茶', 100, 'L')

select*from ShopMenu



insert in 欄位 values (欄位值)
insert in values (欄位值)