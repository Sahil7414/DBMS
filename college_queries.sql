
-- 1. Create College and Department tables
CREATE TABLE College (
    SNO INT PRIMARY KEY,
    SNAME VARCHAR(20),
    Year CHAR(15),
    DOA DATE,
    PCM INT,
    DEPTNO INT
);

CREATE TABLE Department (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(20)
);

-- 2. Insert tuples into both tables
INSERT INTO College VALUES 
(7369, 'Adams', 'First', '2008-06-01', 275, 20),
(7499, 'Brooks', 'Second', '2007-06-01', 265, 10),
(7521, 'Curry', 'Second', '2007-06-01', 255, 30),
(7566, 'Glenn', 'Third', '2006-06-01', 215, 30),
(7654, 'Green', 'Second', '2007-06-01', 220, 30),
(7698, 'Hayes', 'Third', '2006-06-01', 235, 30),
(7782, 'Johnson', 'Third', '2006-06-01', 290, 10),
(7783, 'Jones', 'Third', '2006-06-01', 189, 20),
(7839, 'Lindsay', 'Final', '2005-06-01', 175, 10),
(7844, 'Smith', 'Second', '2007-06-01', 263, 30),
(7876, 'Turner', 'First', '2008-06-01', 285, 20),
(7900, 'Williams', 'First', '2008-06-01', 275, 30),
(7902, 'Adams', 'Third', '2006-06-01', 274, 20),
(7934, 'Brooks', 'First', '2008-06-01', 167, 10);

INSERT INTO Department VALUES
(10, 'Computer'),
(20, 'Electronics'),
(30, 'Civil'),
(40, 'Chemical');

-- 3. Add new attribute Sports Marks (SM)
ALTER TABLE College ADD SM INT;

-- 4. Modify the SM value by 15 for deptno 10
UPDATE College SET SM = 15 WHERE DEPTNO = 10;

-- 5. Students eligible for Sports marks
SELECT SNAME FROM College WHERE SM IS NOT NULL;

-- 6. Names with first letter capital only
SELECT CONCAT(UCASE(LEFT(SNAME,1)), LCASE(SUBSTRING(SNAME,2))) AS NameFormatted FROM College;

-- 7. PCM and percentage (assuming PCM is out of 300)
SELECT SNAME, PCM, (PCM/300)*100 AS Percentage FROM College;

-- 8. Different years
SELECT DISTINCT Year FROM College;

-- 9. Students not in deptno 20, 30, 40
SELECT * FROM College WHERE DEPTNO NOT IN (20, 30, 40);

-- 10. Students with PCM between 250 and 300
SELECT SNAME, PCM FROM College WHERE PCM BETWEEN 250 AND 300;

-- 11. Total, highest, average PCM dept-wise for deptno 30
SELECT DEPTNO, SUM(PCM) AS Total_PCM, MAX(PCM) AS Max_PCM, AVG(PCM) AS Avg_PCM 
FROM College 
WHERE DEPTNO = 30 
GROUP BY DEPTNO 
HAVING AVG(PCM) > 250 
ORDER BY Total_PCM DESC;

-- 12. Students in each department (right join to show dept even if no student)
SELECT c.SNO, c.SNAME, d.DNAME 
FROM Department d LEFT JOIN College c ON c.DEPTNO = d.DEPTNO;

-- 13. Students with same PCM as Williams
SELECT SNAME FROM College WHERE PCM = (SELECT PCM FROM College WHERE SNAME = 'Williams');

-- 14. PL/SQL block for total number of students
-- This is standard SQL for MySQL since PL/SQL is for Oracle
SELECT COUNT(*) AS Total_Students FROM College;

-- 15. Different years in department 10 and 20
SELECT DISTINCT Year FROM College WHERE DEPTNO IN (10, 20);
