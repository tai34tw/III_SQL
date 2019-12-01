SELECT * FROM employee;  -- * = All column
SELECT ename, salary, title FROM employee; -- 從'employee' TABLE 抓 'ename', 'salary', 'title'
SELECT 17 / 4 AS 'a', 17 div 4 AS 'b', 17 % 4 AS 'c', 17 * null AS 'd'; --  練習運算及欄位別名
SELECT  ename AS '員工姓名', salary*12 AS '年薪' FROM employee; -- 取欄位暱稱，但不變動資料庫欄位
SELECT	ename 'Name', salary*12  'Annual Salary' FROM employee; -- AS可忽略不鍵
SELECT substring(ename, 1, 2) '姓名' FROM employee; -- 從'employee' TABLE 之 'ename' 從第1個位置抓2個字元
SELECT substring('David Wang', 1, 5); -- 從字串中之第1個位置抓5個字元
SELECT substring('David Wang', 7); -- 從字串中之第7個位置抓後續字串
SELECT substring('David Wang', -4); -- 從字串中之倒數第4個位置抓後續字串
SELECT substring('David Wang', -4, 2); -- 從字串中之第第4個位置抓2個字元

SELECT concat(ename, 'is a', title) AS '職稱' FROM employee; -- 串接欄位或字串
SELECT length('我是一個student') AS 'length'; -- 計算字串佔多少bytes
SELECT char_length('我是一個student') AS 'length'; -- 計算字串總共多少個字元

SELECT sysdate(); -- 抓現在電腦系統時間 
SELECT sysdate() + interval 1 month; -- 現在電腦時間 + 1 個月
SELECT hiredate + interval 3 month AS '試用期' FROM employee; -- 抓hiredate + 3 個月 = 試用期
SELECT hiredate, hiredate + interval 3 month AS '試用期' FROM employee; -- 較上列多1欄hiredate
SELECT sysdate(), SLEEP(2), sysdate(); -- 抓系統時間,睡2秒,重抓系統時間
SELECT now(), SLEEP(2), now(); -- 抓系統時間,睡2秒,與前次函式回傳值相同，可與上述函式sysdate()比較

SELECT adddate(curdate(), 3); -- 傳回現在日期+3天
SELECT adddate(curdate(), INTERVAL 3 month); -- 傳回現在日期+3個月
SELECT subdate(curdate(), 3); -- 傳回現在日期-3天
SELECT subdate(curdate(), INTERVAL 3 month); -- 傳回現在日期-3個月

SELECT hiredate, year(hiredate) AS 'hiredate', month(hiredate) AS 'hiremonth', day(hiredate) AS 'hireday' FROM employee; -- 分別抓'hiredate'之年,月,日
SELECT now(), year(now()) AS 'nowdate', month(now()) AS 'nowmonth', day(now()) AS 'nowday', time(now()) AS 'nowtime'; -- 分別抓現在年,月,日,時間

SELECT empno, ename, datediff(now(), hiredate) div 365 AS 'year1',  -- 現在日期-雇用日期整除365天
		datediff(now(), hiredate) / 365 AS 'year2',  -- 現在日期-雇用日期除365天
		round(datediff(now(), hiredate) / 365, 1) AS 'year3', -- 現在日期-雇用日期除365天四捨五入小數點第1位
        round(datediff(now(), hiredate) / 365) AS 'year4', -- 現在日期-雇用日期除365天四捨五入
        YEAR(CURDATE())-YEAR(hiredate) AS 'year5', -- 現在年分-雇用年分
        datediff(now(), hiredate) % 365 div 30 AS 'month'
FROM employee;  -- 不同算年資的方法'

SELECT empno, ename, salary,  -- 當條件(salary)為真(>=50000)時，值為salary*2，條件為假(<50000)時，值為salary*1.5
		salary*IF(salary >= 50000, 2, 1.5) AS 'bonus'
FROM employee;

SELECT empno, ename, salary,  -- 完成多種條件的判斷
	CASE
		WHEN salary > 10000 THEN 'A'
        WHEN salary BETWEEN 70000 AND 100000 THEN 'B'
        WHEN salary BETWEEN 50000 AND 69999 THEN 'C'
        WHEN salary BETWEEN 30000 AND 49999 THEN 'D'
        ELSE 'E'
	END AS 'Grade'
FROM employee;

SELECT DISTINCT deptno FROM employee; -- 去除重複資料列
SELECT DISTINCT deptno, title FROM employee; -- 抓出兩欄相加不重複資料列

SELECT * FROM employee WHERE deptno = 100; -- 搜尋deptno欄值為100的紀錄
SELECT * FROM employee WHERE title = 'engineer'; -- 搜尋title欄值為engineer的紀錄
SELECT * FROM employee WHERE hiredate = '2007/07/06';
SELECT * FROM employee WHERE salary >= 50000;
SELECT * FROM employee WHERE salary BETWEEN 30000 AND 49999;
SELECT * FROM employee WHERE title IN ('manager', 'engineer'); -- 搜尋title欄值為manager或engineer的紀錄
SELECT * FROM employee WHERE deptno IS NULL; -- 查詢deptno是否可記錄NULL值

SELECT * FROM employee WHERE ename LIKE '林_%';  -- 關鍵字查詢，_表1個字元，%為0至多個字元
SELECT * FROM employee WHERE title LIKE 'SA\_%'; -- \為跳脫字元

SELECT * FROM employee
	WHERE (deptno = 100 OR  deptno = 300)
    AND (salary >= 40000 AND salary <= 60000)
    AND ename NOT LIKE '潘%'; -- 抓出deptno為100或300；薪水大於40000，小於60000；排除姓潘之名單

SELECT * FROM employee ORDER BY salary ASC; -- 以salary由小排到大
SELECT * FROM employee ORDER BY hiredate DESC; -- 以hiredatey由大排到小

SELECT ename, salary, salary*12 AS 'Annual' FROM employee ORDER BY Annual; -- 將'salary*12'設別名為'Annual'，再由別名('Annual')排序
SELECT * FROM employee LIMIT 3; -- 抓出employee表格前3筆
SELECT * FROM employee ORDER BY hiredate LIMIT 3; -- 抓出最資深的3位員工

SELECT COUNT(*) FROM employee; -- 傳回所有筆數值
SELECT COUNT(deptno) FROM employee; -- 傳回deptno所有非NULL值的筆數
SELECT COUNT(mgrno) FROM department; -- 傳回department所有非NULL值的筆數，mgrno有非NULL值

SELECT deptno, sum(salary), AVG(salary), MAX(salary), MIN(salary) 
	FROM employee
	GROUP BY deptno; -- 回傳不同部門薪水相關值
 SELECT deptno, sum(salary) AS 'SUM', AVG(salary) AS 'AVG', MAX(salary) AS 'MAX', MIN(salary) AS 'MIN'
	FROM employee
	GROUP BY deptno
    ORDER BY AVG(salary) DESC; -- 回傳不同部門薪水相關值，再依平均薪資排序  
    
SELECT deptno, title, sum(salary) AS 'total' FROM employee  -- 傳回不同部門不同職稱之薪資加總
	GROUP BY deptno, title;
    SELECT deptno, title, sum(salary) AS 'total' FROM employee
	GROUP BY deptno, title WITH ROLLUP; -- 較上述多個小計
    
SELECT title, SUM(salary) AS 'Total'  -- 傳回不同職稱的總薪資，但不包含有"SA"這些字的職稱，且總薪資必須超過100000，最後結果以總薪資排序
FROM employee
	WHERE title NOT LIKE '%SA%'
	GROUP BY title 
    HAVING SUM(salary) > 100000
    ORDER BY SUM(salary) DESC;






