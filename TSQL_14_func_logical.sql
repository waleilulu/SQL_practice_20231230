

-- Module 14.系統內建函數- 其餘函數以及CASE 運算式介紹


-- 10. 如果訂單數量大於 100，標示為請再次確認
--		語法： IIF(比較, true, false) 
select * from [Order Details]--因為檔案名中間有個空格要加[]
where Quantity>100--得出有13個大於 100

SELECT *,IIF(Quantity > 100, '要注意超過100', '正常訂單') as SysMemo
FROM [Order Details]--因為檔案名中間有個空格要加[]
Order by Quantity desc



-- 20. 整理出產品名稱和產品類別訊息
--		語法： CHOOSE () 
select CHOOSE(1, 'A', 'B', 'C')--A
select CHOOSE(10, 'A', 'B', 'C')--null

select CHOOSE(1, '已離職', '在職')--已離職
select CHOOSE(2, '已離職', '在職')--在職

select * from Categories --A視窗
select productID, ProductName ,categoryID
	, choose (categoryID, 'beverages', 'Condiments', 'confections', 'dairy products', 'Grains/Cereals','Meat/Poultry', 'Produce', 'Seafood')
	from Products 
	order by productID --B視窗



-- 30. 統計員工資料表的資料，分類出 70歲以上、60歲以上、59歲以下
--		語法：CASE..WHEN..ELSE..END

CASE
	when 員工年紀>=70 then '70歲以上'
	when 員工年紀>=60 then '60歲以上'
	else '59歲以下'
END	

select EmployeeID, BirthDate
	--,year(GETDATE())--系統西元年: 2023
	--,year(BirthDate)--員工出生年 
	,year(GETDATE())-year(BirthDate) as Age
	,CASE
		when year(GETDATE())-year(BirthDate)>=70 then '70歲以上'
		when year(GETDATE())-year(BirthDate)>=60 then '60歲以上'
		else '59歲以下'
	END	as SysMessage
from Employees


--50. 假如電話簿中有手機、家裡電話、辦公室電話
--    這三者欄位可能有些會是空白
--    我們想要依照順序挑選，手機優先、家裡電話次之、辦公室電話最末
--	  該如何撰寫才可以達到目標？

--    ID        Phone
--    --------- --------
--    1         M1
--    2         H2
--    3         M3
--    4         M4
--    5         O5
--    6         NULL



-- 作法
-- IIF
select*,IIF (mobilephone is not NULL, Mobilephone
			, IIF(homephone is not NULL, homephone, officephone))
from Lab14
-- 語法：CASE..WHEN..ELSE..END
SELECT *
    ,CASE
        WHEN  MobilePhone IS NOT NULL THEN MobilePhone
        WHEN  HomePhone IS NOT NULL THEN HomePhone
        WHEN  OfficePhone IS NOT NULL THEN OfficePhone
        ELSE '這個人三個電話都沒有，需要確認'
    END


    FROM Lab14




-- ISNULL-- =>專門用在NULL
SELECT *, ISNULL(MobilePhone, '貓咪')
    FROM Lab14
SELECT *, ISNULL(MobilePhone, ISNULL(HomePhone, OfficePhone))
    FROM Lab14




-- COALESCE() --=>專門用在NULL
SELECT *, COALESCE(MobilePhone, HomePhone, OfficePhone, '要小心')




-- 確認所選取的資料庫為 Lab 後，框選底下程式碼直接執行
CREATE TABLE Lab14(
	ID int identity(1,1) not null,
	MobilePhone varchar(10) null,
	HomePhone   varchar(10) null,
	OfficePhone varchar(10) null
)

insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values ('M1','H1','O1');
insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values (null,'H2','O2');
insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values ('M3',null,'O3');
insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values ('M4','H4',null);
insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values (null,null,'O5');
insert into Lab14 (MobilePhone, HomePhone, OfficePhone) values (null,null,null);

select * from Lab14;


