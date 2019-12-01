-- 1. 以不列舉欄位的方式新增一筆食物資料
INSERT INTO	food
VALUES		('CK007', '泡芙', '2019/05/08', 'TW', 120, '點心', NULL);
-- 2. 以列舉欄位的方式新增一筆食物資料
INSERT INTO	food (no, name, expiredate, placeid, price, catalog, New_Price)
VALUES		('CK006', '薯片', '2020/09/08', 'TW', 160, '點心', NULL);
-- 3. 以不列舉欄位的方式新增多產地資料
INSERT INTO	place
VALUES		('PH', '菲律賓'), ('KR','韓國');
-- 4. 修改一筆食物資料的價格
UPDATE 	food
SET	   	price = '60'
WHERE	no	= 'CK007';
-- 5. 按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
SELECT name AS '食物名稱', price AS '價格',
CASE 
	WHEN price <= 250 THEN TRUNCATE (price*1.08,0) 
    WHEN price BETWEEN 251 AND 500 THEN TRUNCATE(price*1.05,0)
    WHEN price > 501 THEN TRUNCATE(price*1.03,0)
END AS 'New Price'
FROM food;
-- 6. 刪除一筆食物資料
DELETE FROM food	
WHERE no = 'CK007';