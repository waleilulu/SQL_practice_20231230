 複合式主鍵: 主鍵由一個以上的資料行組成
 舉例來說，存儲學生課程成績的資料表可能使用學生的學號和課程編號兩個欄位組成複合式主鍵，以確保每一筆紀錄都能夠唯一識別一位學生在特定課程中的成績。
CREATE TABLE 訂單 (
    訂單ID INT,
    產品ID INT,
    PRIMARY KEY (訂單ID, 產品ID),
    數量 INT
);

 1. 能不能多一個資料行?
    where 要寫很多 → 多一個資料行 → where 寫入比較簡單，但需要多花很多空間。

 2. 我現在下單的時候看到的畫面好像不一樣?
    Y: 寫判斷 → 不好寫、沒時間，就寫成一行一行的
    N: 資料庫設計要想一下
    購物車，每加購一次可樂，購物車列變多一行可樂，又或者是購物車會統計可樂的總數

3. 店數可以換錢
    放 訂單主檔   / 訂單頭檔: 整張訂單
    放 訂單明細檔 / 訂單身檔: 個別品項

4. 折扣好多，合併嗎?
    某日本機場
    某金額 - (零錢 + 折價券 + 員工折扣) = 刷卡金額
    → 折價券、折扣要不要合併，需不需要分析統計: 折價券的效益(效益不好，就不要再印發折價券了)、員工用了多少員工權益

-- Module 15.多表格聯結(Join) 的基本查詢語法
select*from orders;
select * from [order details]

-- 10. 觀察 Orders 和 Order Details 資料表，兩張資料表內各自存放了什麼資料？
---     試著處理底下問題：
---     a. 如果想要知道客戶有多少訂單，需要哪些資料表? select * from orders
---     b. Order Details 資料表 是否有小計金額? (x)
        Y: 要有小計 → 挑選資料方便
        N: 不需要 → 可以計算、省資料庫空間

-- 13. 如何找到有包含折扣的訂單？

select * from [order details]
where discount > 0 -- 有三種方法表示
where discount <> 0
where discount != 0

--     以及有幾種折扣？
select *, (UnitPrice*Quantity*Discount)as'小計'
from [order details]--show出 每筆的小計

select distinct discount
from [order details]
order by Discount--show出幾種折扣

select *, (UnitPrice*Quantity*1-Discount)as'小計' --1-0.2=8折 = 20% off
from [order details]
order by Discount desc


-- 20. 訂單編號 10847 一共購買了幾個產品？
select *, (UnitPrice*Quantity*1-Discount)as'小計'
from [order details]
where OrderID=10847 --買了六樣商品


-- 21. 延續 20. 該如何得知產品名稱？
select* from Products; --找到產品序號的名稱


-- 30. 透過 join 語法，把需要的資料表連接再一起
select*
from [Order Details] as X
left join Products as Y on X.ProductID = Y. ProductID--把Order Details跟Products連在一起

--   需要的欄位：訂單編號、產品名稱、單價、數量、折扣、小計 等
select OrderID, ProductName, X.UnitPrice, X.Quantity, X.Discount
from [Order Details] as X
left join Products as Y on X.ProductID = Y. ProductID

Q: 為什麼會出現:「模稜兩可的資料名稱'XXX'」
A: 因為資料表join再一起後「可能」會有相同的資料行
-- UnitPrice，Order Details跟Products裡都有UnitPrice，要講清楚是誰的。X.UnitPrice 或是 Y.UnitPrice

select*
from [Order Details] as X
left join Products as Y on X.ProductID = Y. ProductID
where OrderID=10248--找出10248訂單，Order Details跟Products的ProductID


select OrderID, ProductName, X.UnitPrice, Y.UnitPrice
from [Order Details] as X
left join Products as Y on X.ProductID = Y. ProductID
where X.UnitPrice != Y.UnitPrice
--找出Order Details跟Products的UnitPrice，是不相同的價格，有658筆
