
-- 1. Create Player and Country tables
CREATE TABLE Player59 (
    Pid INT,
    Pname VARCHAR(20),
    Role VARCHAR(20),
    Age INT,
    Runs INT,
    Wicket INT,
    Tid INT,
    NOM INT(3)
);

CREATE TABLE Country59 (
    Tid INT,
    Cname VARCHAR(15)
);

-- 2. Insert all tuples
INSERT INTO Player59 VALUES (1001, 'Sachin', 'Batsman', 25, 10000, 45, 101, NULL);
INSERT INTO Player59 VALUES (1002, 'Jaywardhne', 'Captain', 29, 5000, NULL, 102, NULL);
INSERT INTO Player59 VALUES (1003, 'Kapil', 'Bowler', 30, 2000, 470, 103, NULL);
INSERT INTO Player59 VALUES (1004, 'Clark', 'Batsman', 27, 3000, 120, 104, NULL);
INSERT INTO Player59 VALUES (1005, 'Gautam', 'Batsman', 28, 20000, NULL, 101, NULL);
INSERT INTO Player59 VALUES (1006, 'Rahul', 'Batsman', 22, 15000, NULL, 101, NULL);
INSERT INTO Player59 VALUES (1007, 'Vas', 'Bowler', 28, 3000, 480, 102, NULL);
INSERT INTO Player59 VALUES (1008, 'Flintop', 'Bowler', 24, 6200, 190, 103, NULL);
INSERT INTO Player59 VALUES (1009, 'Hussy', 'Batsman', 29, 2900, NULL, 104, NULL);
INSERT INTO Player59 VALUES (1010, 'Murlidharan', 'Bowler', 31, 1800, 500, 102, NULL);
INSERT INTO Player59 VALUES (1011, 'Laxman', 'Batsman', 21, 5200, NULL, 101, NULL);
INSERT INTO Player59 VALUES (1112, 'Dhoni', 'Wicketkeeper', 24, 4500, NULL, 101, NULL);

INSERT INTO Country59 VALUES (101, 'India');
INSERT INTO Country59 VALUES (102, 'Shrilanka');
INSERT INTO Country59 VALUES (103, 'England');
INSERT INTO Country59 VALUES (104, 'Australia');
INSERT INTO Country59 VALUES (105, 'South Africa');

-- 3. Modify the width of NOM
ALTER TABLE Player59 MODIFY COLUMN NOM INT(4);

-- 4. Set NOM = 75
UPDATE Player59 SET NOM = 75;

-- 5. Batsmen for Tid = 101
SELECT Pname FROM Player59 WHERE Role = 'Batsman' AND Tid = 101;

-- 6. Country name containing 'N'
SELECT Cname FROM Country59 WHERE Cname LIKE '%N%';

-- 7. Name, Runs, SR
SELECT Pname, Runs, (Runs / NOM) AS SR FROM Player59;

-- 8. Distinct Tids
SELECT DISTINCT Tid FROM Player59;

-- 9. Names ending with 'N'
SELECT Pname FROM Player59 WHERE Pname LIKE '%N';

-- 10. Runs between 2000 and 8000
SELECT Pname, Runs FROM Player59 WHERE Runs BETWEEN 2000 AND 8000;

-- 11. Aggregation for Tid = 101
SELECT 
    Tid,
    SUM(Runs) AS TotalRuns,
    MAX(Runs) AS MaxRuns,
    AVG(Runs) AS AvgRuns
FROM Player59
WHERE Tid = 101
GROUP BY Tid
HAVING AVG(Runs) > 1000
ORDER BY TotalRuns ASC;

-- 12. Player with Country name
SELECT P.Pid, P.Pname, P.Tid, C.Cname
FROM Player59 P
JOIN Country59 C ON P.Tid = C.Tid;

-- 13. Players with same Tid as Sachin
SELECT Pname FROM Player59
WHERE Tid = (SELECT Tid FROM Player59 WHERE Pname = 'Sachin');

-- 14. Create view with pname, age, avg runs
CREATE VIEW PlayerStats AS
SELECT Pname, Age, (Runs / NOM) AS AvgRuns FROM Player59;

-- 15. Common roles in Tid 102 and 103
SELECT Role FROM Player59
WHERE Tid = 102
AND Role IN (SELECT Role FROM Player59 WHERE Tid = 103);
