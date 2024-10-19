 

-- Module 10.欄位為空值時的查詢以及將查詢的結果予以排序


-- 補充資料：SELECT 陳述式的邏輯處理順序
--https://docs.microsoft.com/zh-tw/sql/t-sql/queries/select-transact-sql?view=sql-server-ver15#logical-processing-order-of-the-select-statement



-- 10. 挑選供應商資料中，傳真號碼為空值(NULL)的資料
select SupplierID, Fax from Suppliers
where Fax is Null--查詢值為 Null 的資料，應使用 is Null 而不是直接使用等號


-- 15. 討論幾種不等於的寫法 != 、 <> 、 not
select SupplierID, Fax from Suppliers where Fax is not Null
select SupplierID, Fax from Suppliers where SupplierID !=1
select SupplierID, Fax from Suppliers where SupplierID <>1

select SupplierID from Suppliers where SupplierID >=20
select SupplierID from Suppliers where not SupplierID <20



-- 20. 挑選供應商資料中，傳真號碼不等於 '43844115' 的資料
select Fax from Suppliers where fax !='43844115' or fax is Null--28筆


-- 25. 如果排序的欄位挑選 Fax，出來的結果是什麼？
select SupplierID, Fax from Suppliers order by Fax --小到大排序，Null會被排在最前面


-- 30. 別名是否可以在 order by 中使用？ (o)可以
select SupplierID, Country as Apple from Suppliers order by Apple

--     別名是否可以在   where  中使用？ (x)不行

---執行順序 from → where → select → order by



