-- 外顯式交易之ROLLBACK:資料回復原有狀態
START TRANSACTION;
INSERT INTO department VALUES (601, 'RD', 1001);
INSERT INTO department VALUES (602, 'IT', NULL);
SELECT * FROM department; 			-- (a) 第1次查詢
ROLLBACK;
SELECT * FROM department; 			-- (b) 第2次查詢
-- 外顯式交易之Commit:資料進去
START TRANSACTION;
INSERT INTO department VALUES (601, 'RD', 1001);
INSERT INTO department VALUES (602, 'IT', NULL);
SELECT * FROM department; 			-- (a) 第1次查詢
Commit;
SELECT * FROM department; 			-- (b) 第2次查詢

-- 隱含式交易
SET AUTOCOMMIT = 0;
INSERT INTO department VALUES (603, 'RD', 1001);
INSERT INTO department VALUES (604, 'IT', NULL);
SELECT * FROM department; 			-- (a) 第1次查詢
ROLLBACK;
SELECT * FROM department; 			-- (b) 第2次查詢
INSERT INTO department VALUES (605, 'RD', 1001);
INSERT INTO department VALUES (606, 'IT', NULL);
SELECT * FROM department; 			-- (c) 第3次查詢
Commit;
SELECT * FROM department; 			-- (d) 第4次查詢
SET AUTOCOMMIT = 1;

-- SAVE POINT
BEGIN;
SELECT 	empno, ename, salary							-- 第1次查詢
FROM 	employee
WHERE 	empno IN (1001, 1002, 1003);

UPDATE employee SET salary = 60000 WHERE empno = 1001;
SAVEPOINT A;  											-- 儲存點A
UPDATE employee SET salary = 40000 WHERE empno = 1002;
SAVEPOINT B;                                            -- 儲存點B
UPDATE employee SET salary = 80000 WHERE empno = 1003;
SAVEPOINT C;											-- 儲存點C

ROLLBACK TO A;
COMMIT; 
SELECT 	empno, ename, salary							-- 第2次查詢
FROM 	employee
WHERE 	empno IN (1001, 1002, 1003);
END;

-- 交易鎖定
BEGIN;
SELECT 	salary				-- 第1次查詢
FROM 	employee
WHERE 	empno = 1001;

UPDATE 	employee
SET		salary = 60001
WHERE 	empno = 1001;

COMMIT;						-- 確認交易，釋放1001鎖定

SELECT 	salary				-- 第2次查詢
FROM 	employee
WHERE 	empno = 1001;

SELECT 	salary				-- 當user2 COMMIT後，第3次查詢
FROM 	employee
WHERE 	empno = 1001;
END;
