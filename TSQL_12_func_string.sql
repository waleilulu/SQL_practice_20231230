

-- Module 12.系統內建函數- 字串函數介紹 


-- 補充資料：字串函數 (Transact-SQL)
--https://docs.microsoft.com/zh-tw/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver15



-- 10. 測試 LEN() 與 DATALENGTH() 
--     在實際執行前，請預測產生的資料為何？
select Len('abc'), Len('a b c'), Len('a b c ')--3, 5, 5(會刪除末端的空格，不列入計算)
select DataLength('abc'), DataLength('a b c'), DataLength('a b c ')--3, 5, 6


-- 11. LEN() 與 DATALENGTH() 在計算中文和英文是否有所不同？
--     底下的SQL有寫入資料和更新資料，執行前請確認步驟

    select * from Lab.dbo.Lab061;


    insert into Lab.dbo.Lab061 
    (c, nc, v, nv) 
    values 
    ('apple蘋果', 'apple蘋果', 'apple蘋果', 'apple蘋果');

    select * from Lab.dbo.Lab061;


    -- !! 注意底下指令 where 條件 id = 5
    -- 請依照目前電腦中取得的 id 號碼進行搜尋，目標是取得剛剛那筆新增的資料 apple蘋果


    select Len(C), Len(NC), Len(V), Len(NV) 
      from Lab.dbo.Lab061
     where id = 5

    update Lab.dbo.Lab061 set c  = c  + '123' where id = 5;--訊息 2628，層級 16，狀態 1，行 1資料表 'Lab.dbo.Lab061'，資料行 'C' 中的字串或二進位資料將會截斷。截斷的值: 'apple蘋果 '。

    update Lab.dbo.Lab061 set nc = nc + '123' where id = 5;--訊息 2628，層級 16，狀態 1，行 2 資料表 'Lab.dbo.Lab061'，資料行 'NC' 中的字串或二進位資料將會截斷。截斷的值: 'apple蘋果   '。

    update Lab.dbo.Lab061 set v  = v  + '123' where id = 5;--訊息 2628，層級 16，狀態 1，行 3 資料表 'Lab.dbo.Lab061'，資料行 'V' 中的字串或二進位資料將會截斷。截斷的值: 'apple蘋果1'。
   
    update Lab.dbo.Lab061 set nv = nv + '123' where id = 5;-- OK



    -- 測試 DataLength() 前，將資料更新回來
    update Lab.dbo.Lab061 set nv = 'apple蘋果' where id = 5;
    select DataLength(C), DataLength(NC), DataLength(V), DataLength(NV) 
    from Lab.dbo.Lab061
    where id = 5
    --10(char)	20(nchar)	9(varchar)	14(nvarchar)

    --10(char) 一定要輸入10個字數，如果沒有寫滿會補滿到10，apple+蘋果+3個空格=10
    --20(nchar) (apple+蘋果+自動補3格)*2=20
    --9(varchar) apple+蘋果(一個中文字算2格)=9
    --varchar(14) (apple+蘋果)*2=14



-- 12. 小複習：該如何挑選出 c 欄位中包含空白的資料？
select*
from Lab.dbo.Lab061
where id =5 and C like'% %'


-- 20. 假設員工資料表中 HomePhone 電話()中的號碼為區碼，該如何取得？
  408
--四零八->郵遞區號->字串
--四百零八->$     ->數字->計算
--四洞八->字串

--		substring(欄位, 起始位置, 長度)
select EmployeeID, HomePhone, SUBSTRING(HomePhone,1 , 8) from Employees;

--      charindex(想要搜尋的字元, 欄位)
select EmployeeID, HomePhone, SUBSTRING(HomePhone,1 , 8), charindex('2', HomePhone) from Employees;
select EmployeeID, HomePhone, SUBSTRING(HomePhone,1 , 8), charindex('-', HomePhone) from Employees;--告訴你-在第幾個位置

-- 25. 同樣測試 HomePhone 欄位，透過 left() 從左邊擷取 5 ，會得到什麼結果？
--		left(欄位, 位數)、right(欄位, 位數)，從字串的左邊或者右邊開始擷取
select EmployeeID, LastName
, left(LastName, 3)--把左邊三個字擷取下來
, right(LastName, 2)--把右邊兩個字擷取下來
 from Employees
 where EmployeeID in (1,5)



select EmployeeID, HomePhone,   SUBSTRING(HomePhone, 2, CHARINDEX(')', HomePhone) - 2) AS 區碼 from Employees -- where EmployeeID = 1 or EmployeeID = 5 / where EmployeeID in (1, 5) 一樣的
select EmployeeID, HomePhone, left(homephone,5) as 區碼 from Employees
select EmployeeID, HomePhone, right( left(homephone, charindex(')', homephone)-1),len(left(homephone, charindex(')', homephone)-1))-1) from Employees


select EmployeeID,HomePhone
,left(homephone, charindex(')', homephone)-1)
--,replace('(206','(','')
,replace(left(homephone, charindex(')', homephone)-1), '(','')

--right( ,len()-1)
,right( left(homephone, charindex(')', homephone)-1),len(left(homephone, charindex(')', homephone)-1))-1)







-- 30. replace(字串, 想要尋找的文字, 要取代的文字) 可以取代掉指定的字元
--		請嘗試透過 left() 和 replace() 獲得和 步驟 20 一樣的結果

select EmployeeID, LastName
, replace(LastName, 'a', '')--把a換成空格
 from Employees
 where EmployeeID in (1,5)


		
-- 40. 【小練習】轉出資料時，為了保護資料的安全，
--		希望 LastName 不要全部提供，只顯示前三碼，後面有幾位改以 * 取代
--		請在 上方的 補充資料：字串函數 (Transact-SQL) 中搜尋，是否有函式可以幫我們達成？
SELECT EmployeeID, LastName,
  LEFT(LastName, 3) + REPLICATE('*', LEN(LastName) - 3) AS 目標結果
FROM Employees;




我希望擷取名字的前三碼-- left()
我希望知道名字總共多長，然後-3，就是我要補的數量--len()-3
不知道有沒有含是可以協助"指定的字串重複指定的次數"--40 題提示：REPLICATE()
我希望把名字前三碼跟**串再一起--+

SELECT EmployeeID, LastName
  ,LEFT(LastName, 3) 
  ,len(lastname)-3
  ,REPLICATE('*', 7)
  ,LEFT(LastName, 3) + REPLICATE('*', len(lastname)-3) AS 目標結果
FROM Employees;

-- 防雷頁

