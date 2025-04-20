-- 1. Create College and Department table
CREATE TABLE College (
    SNO INT PRIMARY KEY,
    SNAME VARCHAR(20),
    Year CHAR(15),
    DOA DATE,
    PCM INT,
    SM INT,
    DEPTNO INT
);

CREATE TABLE Department (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(20)
);

-- 2. Insert all tuples
INSERT INTO College VALUES 
(7369, 'adams', 'First', '2008-06-01', 275, NULL, 20),
(7499, 'brooks', 'Second', '2007-06-01', 265, NULL, 30),
(7521, 'curry', 'Second', '2007-06-01', 255, NULL, 30),
(7566, 'glenn', 'Third', '2006-06-01', 215, NULL, 20),
(7654, 'green', 'Second', '2007-06-01', 220, NULL, 30),
(7698, 'hayes', 'Third', '2006-06-01', 235, NULL, 30),
(7782, 'johnson', 'Third', '2006-06-01', 290, NULL, 10),
(7783, '_jones', 'Third', '2006-06-01', 189, NULL, 20),
(7839, 'lindsay', 'Final', '2005-06-01', 175, NULL, 10),
(7844, 'smith', 'Second', '2007-06-01', 263, NULL, 30),
(7876, 'turner', 'First', '2008-06-01', 285, NULL, 20),
(7900, 'williams', 'First', '2008-06-01', 253, NULL, 30),
(7902, 'adams', 'Third', '2006-06-01', 274, NULL, 20),
(7934, 'brooks', 'First', '2008-06-01', 167, NULL, 10);

INSERT INTO Department VALUES
(10, 'Computer'),
(20, 'Electronics'),
(30, 'Civil'),
(40, 'Chemical');

-- 3. Modify SM width
ALTER TABLE College MODIFY SM INT(4);

-- 4. Modify SM to 10 for deptno 20
UPDATE College SET SM = 10 WHERE DEPTNO = 20;

-- 5. Second year students in dept 10
SELECT SNAME FROM College WHERE Year = 'Second' AND DEPTNO = 10;

-- 6. Students ending with 's'
SELECT SNAME FROM College WHERE SNAME LIKE '%s';

-- 7. Name, PCM, Percentage (assuming out of 300)
SELECT SNAME, PCM, (PCM/300.0)*100 AS Percentage FROM College;

-- 8. Distinct deptnos
SELECT DISTINCT DEPTNO FROM College;

-- 9. Names ending with 'n'
SELECT SNAME FROM College WHERE SNAME LIKE '%n';

-- 10. Admission after 01-Jun-07 and before 01-Jun-08
SELECT SNAME, DOA FROM College WHERE DOA > '2007-06-01' AND DOA < '2008-06-01';

-- 11. Aggregation for deptno 20 with avg > 250
SELECT DEPTNO, SUM(PCM) AS Total_PCM, MAX(PCM) AS Max_PCM, AVG(PCM) AS Avg_PCM
FROM College
WHERE DEPTNO = 20
GROUP BY DEPTNO
HAVING AVG(PCM) > 250
ORDER BY Total_PCM ASC;

-- 12. Student info with department name
SELECT C.SNAME, C.Year, C.DEPTNO, D.DNAME
FROM College C
JOIN Department D ON C.DEPTNO = D.DEPTNO;

-- 13. Students in same dept as 'smith'
SELECT SNAME FROM College
WHERE DEPTNO = (SELECT DEPTNO FROM College WHERE LOWER(SNAME) = 'smith');

-- 14. View with sno, sname, pcm
CREATE VIEW StudentMarksView AS
SELECT SNO, SNAME, PCM FROM College;

-- 15. Common years in dept 10 and 20
SELECT DISTINCT C1.Year 
FROM College C1
JOIN College C2 ON C1.Year = C2.Year
WHERE C1.DEPTNO = 10 AND C2.DEPTNO = 20;
