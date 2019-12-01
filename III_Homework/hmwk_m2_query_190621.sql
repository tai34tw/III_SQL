-- 1
DESC food;
-- 2
SELECT * 
FROM food; 
-- 3
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food;
-- 4
SELECT DISTINCT name
FROM food;
-- 5
SELECT CONCAT(name,' ',catalog) AS 'Food name & catalog'
FROM food;
-- 6
SELECT name AS '食物名稱', price AS '價格'
FROM food
WHERE price > 400; 
-- 7
SELECT name AS '食物名稱', price AS '價格'
FROM food
WHERE price BETWEEN 250 AND 530; 
-- 8
SELECT name AS '食物名稱', price AS '價格'
FROM food
WHERE price < 250 OR price > 530; 
-- 9
SELECT name AS '食物名稱',catalog AS '種類', price AS '價格'
FROM food
WHERE catalog LIKE '種類'; 
-- 10
SELECT name AS '食物名稱',catalog AS '種類', price AS '價格'
FROM food
WHERE catalog LIKE '點心＝種類' OR catalog LIKE '飲料'; 
-- 11
SELECT name AS '食物名稱', placeid AS '產地', price AS '價格'
FROM food
WHERE placeid LIKE 'TW' OR placeid LIKE 'JP'; 
-- 12
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
WHERE name LIKE '%油%';
-- 13
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
WHERE expiredate < '2019/12/31';
-- 14
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
WHERE expiredate < '2020/06/30';
-- 15
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
WHERE expiredate BETWEEN  NOW()-INTERVAL 3 MONTH AND NOW()+INTERVAL 3 MONTH;
-- 16
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
ORDER BY price DESC;
-- 17
SELECT name AS '食物名稱', expiredate AS '到期日', price AS '價格'
FROM food
ORDER BY price DESC
LIMIT 0, 3;
-- 18
SELECT name AS '食物名稱', catalog AS '種類', price AS '價格'
FROM food
WHERE catalog LIKE '點心' AND price < 250
ORDER BY price DESC
LIMIT 0, 3;
-- 19
ALTER TABLE food ADD New_Price int unsigned; 
SELECT name AS '食物名稱', catalog AS '種類', price AS '價格', ROUND(price*1.05,0) AS 'New Price'
FROM food;
-- 20
SELECT name AS '食物名稱', catalog AS '種類', price AS '價格', ROUND(price*1.05,0) AS 'New Price', ROUND(price*1.05,0) - price AS 'Increase'
FROM food;
-- 21
SELECT name AS '食物名稱', price AS '價格',
CASE 
	WHEN price <= 250 THEN ROUND(price*1.08,0) 
    WHEN price BETWEEN 251 AND 500 THEN ROUND(price*1.05,0)
    WHEN price > 501 THEN ROUND(price*1.03,0)
END AS 'New Price'
FROM food;
-- 22
SELECT name AS '食物名稱', expiredate AS '到期日',DATEDIFF(expiredate, now()) AS 'Days of expired',
IF(DATEDIFF(expiredate, now())> 0,'not', 'expired')
FROM food;
-- 23
SELECT name AS '食物名稱', expiredate AS '到期日',DATEDIFF(expiredate, now()) AS 'Days of expired',
IF(DATEDIFF(expiredate, now())> 0,'not', 'expired')
FROM food
ORDER BY DATEDIFF(expiredate, now()) ASC;
-- 24
SELECT MAX(price) AS MAX, MIN(price) AS Min, SUM(price) AS Sum, AVG(price) AS Avg
FROM food;
-- 25
SELECT catalog AS '種類', MAX(price) AS MAX, MIN(price) AS Min, SUM(price) AS Sum, AVG(price) AS Avg
FROM food
GROUP BY catalog;
-- 26
SELECT catalog AS '種類', AVG(price) AS Avg
FROM food
GROUP BY catalog
HAVING Avg > 300
ORDER BY Avg DESC;
-- 27
SELECT catalog AS '種類', COUNT(catalog) AS '食物種類數量'
FROM food
GROUP BY catalog
ORDER BY COUNT(catalog);
-- 28
SELECT placeid AS '產地', COUNT(catalog) AS '食物種類數量' 
FROM food
GROUP BY placeid
HAVING COUNT(catalog);
