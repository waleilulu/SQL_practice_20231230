

-- Module 7.DML指令的使用──如何做資料的修改與刪除 


-- 10. 執行底下語法，建立測試資料表
--		確認所選取的資料庫為 Lab 後，框選底下程式碼直接執行
create table Lab07
(
	CategoryID int IDENTITY(1,1) NOT NULL,
	AvgPrice decimal(6,4) NULL,--六個位數裡面要有四個小數點
	Memo varchar(50) NULL,
	UpdateDate datetime NULL
);

DECIMAL(precision, scale)
總位數（precision）：這是數字的總位數，包括整數和小數部分。
小數位數（scale）：這是小數點後的位數。


insert into Lab07 (AvgPrice) values (37.9791);
insert into Lab07 (AvgPrice) values (23.0625);
insert into Lab07 (AvgPrice) values (25.16);
insert into Lab07 (AvgPrice) values (28.73);
insert into Lab07 (AvgPrice) values (20.25);
insert into Lab07 (AvgPrice) values (54.0066);
insert into Lab07 (AvgPrice) values (32.37);
insert into Lab07 (AvgPrice) values (20.6825);
insert into Lab07 (AvgPrice) values (1.23445);--1.2344
insert into Lab07 (AvgPrice) values (1.23445);--1.2345，小數點後第五位四捨五入至第四位
insert into Lab07 (AvgPrice) values (99.23445);--99.2345，小數點後第五位四捨五入至第四位
insert into Lab07 (AvgPrice) values (100.23445);--(X)轉換 numeric 到資料類型 numeric 時發生算術溢位錯誤。

select * from Lab07;

-- 所以前面創立表格時指示AvgPrice decimal(6,4)的意思就是: 
-- 第一條件為小數點後必須要有四位，小數點後第五位四捨五入至第四位
-- 第二條件為小數點後四位再加上整數位最大整能有六位


-- 20. 更新異動日期欄位 UpdateDate 
--		執行後有多少資料被異動了？
-- 公式:
UPDATE table_name SET column1 = value1, column2 = value2, ...
WHERE condition;

UPDATE Lab07 SET UpdateDate = GETDATE();
--如果沒有添加WHERE指令，8筆的UpdateDate被添增了資訊


UPDATE table_name SET column1 = value1, column2 = value2, ...
WHERE condition;--如果只想單獨添增一筆，需要在WHERE這寫入表頭的對應欄位(PK欄位)


-- 21. 更新 類別編號 為1號的平均單價為 10 元
UPDATE Lab07 SET AvgPrice = 10
Where CategoryID = 1;
select*from Lab07

把超夢放到6號店:
select*from ShopEmployee;
UPDATE ShopEmployee set ShopID =6
WHERE EMPID =6;
select*from ShopEmployee;



-- 29. delete 特定資料
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
DELETE FROM 客戶欄 WHERE CustomerName='客戶名字';


TRUNCATE TABLE   
{ database_name.schema_name.table_name | 
				schema_name.table_name | 
							table_name }  

DROP TABLE [ IF EXISTS ] { database_name.schema_name.table_name | schema_name.table_name | table_name } [ ,...n ]  
[ ; ]  


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

-- 可以執行成功，但是現在(O)，未來(X)
update ShopMenu set DinnkName ='綠茶'
where DrinkName = '綠茶'


-- 可以執行成功，現在(O)，未來(O)
update ShopMenu set DinnkName ='玉露綠茶'
where DrinkName = '綠茶'


update ShopMenu set DinnkName ='玉露綠茶'
where ID = 1 --where後面的條件，寫入primay key的值 (通常都是ID)



-- 30. 執行 delete Lab07，然後再次重新新增資料
--		觀察流水號的變化
select*from Lab07
Delete from Lab07 where CategoryID = 1
select*from Lab07



Delete from Lab07 
select*from Lab07----【內容】被刪除
Insert into Lab07 (Memo)values('皮卡丘')--再新增一筆
select*from Lab07----流水號為9


-- 31. 執行 truncate table Lab07，然後再次重新新增資料
--		觀察流水號的變化
truncate table Lab07
select*from Lab07----【整個表格】被刪除
Insert into Lab07 (Memo)values('皮卡丘')--再新增一筆，會重新重置流水號
select*from Lab07----流水號為1


-- 32. 執行 drop table Lab07，然後再次重新新增資料
--		觀察流水號的變化
drop table Lab07
Insert into Lab07 (Memo)values('皮卡丘')--訊息 208，層級 16，狀態 1，行 1 無效的物件名稱 'Lab07'。
select*from Lab07---【整個表格、全部資料、dbo.Lab07檔案】都被刪除，不被保留。


--MSIT56在明年四月結訓
--資展--> 學生 (C# JAVA 前端 全端)
--真的不需要學生資料了嗎?
--學生狀態->想存什麼值->資料型態

1 DELETE    刪   單一 或者 全部          資料列
2 TRUNCATE  刪   {整個|全部|整體|ALL}  資料列
3 DROP      刪   {表格|檔案} 結構
4 以上皆非

答案是4以上皆非

取消訂單->你還看的到訂單嗎?-- UPDATE (可以看到取消的定單，只是訂單狀態改變)
作廢、註銷、取消會員-- UPDATE
刪除-- UPDATE


