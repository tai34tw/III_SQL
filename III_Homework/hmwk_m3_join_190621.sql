SELECT * FROM food, place;
-- 1
SELECT f.name, f.placeid, p.name, f.price 
FROM food AS f JOIN place AS p
ON f.placeid = p.no;
-- 2
SELECT CONCAT (f.name, ' ', p.name) 
FROM food AS f JOIN place AS p
ON f.placeid = p.no;
-- 3
SELECT  f.name, f.placeid, p.name, f.price 
FROM food AS f JOIN place AS p
ON f.placeid = p.no
WHERE p.name LIKE '%台灣%';
-- 4
SELECT  f.name, f.placeid, p.name, f.price 
FROM food AS f JOIN place AS p
ON f.placeid = p.no
WHERE p.name LIKE '%台灣%' OR '%日本%'
ORDER BY f.price DESC;
-- 5
SELECT  f.name, f.expiredate, f.placeid, p.name, f.price 
FROM food AS f JOIN place AS p
ON f.placeid = p.no
WHERE p.name LIKE '%台灣%'
ORDER BY f.price DESC
LIMIT 0, 3;
-- 6
SELECT p.name AS '產地', ROUND(MAX(f.price),0) AS 'Max', ROUND(MIN(f.price),0) AS 'Min', ROUND(SUM(f.price),0) AS 'Sum', ROUND(AVG(f.price),0) AS 'Avg'
FROM food AS f JOIN place AS p
ON f.placeid = p.no
GROUP BY p.name;
-- 7
SELECT f.catalog AS '種類', p.name AS '產地', COUNT(f.catalog) AS '食物數量'
FROM food AS f JOIN place AS p
ON f.placeid = p.no
GROUP BY f.catalog, p.name;
