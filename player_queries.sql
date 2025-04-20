
-- 1. Create Player and Country tables
CREATE TABLE Player59 (
    Pid INT,
    Pname VARCHAR(20),
    Role VARCHAR(20),
    Age INT,
    Runs INT,
    Wicket INT,
    Tid INT
);

CREATE TABLE Country59 (
    Tid INT,
    Cname VARCHAR(15)
);

-- 2. Insert all tuples
INSERT INTO Player59 VALUES (1001, 'Sachin', 'Batsman', 25, 10000, 45, 101);
INSERT INTO Player59 VALUES (1002, 'Jaywardhne', 'Captain', 29, 5000, NULL, 102);
INSERT INTO Player59 VALUES (1003, 'Kapil', 'Bowler', 30, 2000, 470, 103);
INSERT INTO Player59 VALUES (1004, 'Clark', 'Batsman', 27, 3000, 120, 104);
INSERT INTO Player59 VALUES (1005, 'Gautam', 'Batsman', 28, 20000, NULL, 101);
INSERT INTO Player59 VALUES (1006, 'Rahul', 'Batsman', 22, 15000, NULL, 101);
INSERT INTO Player59 VALUES (1007, 'Vas', 'Bowler', 28, 3000, 480, 102);
INSERT INTO Player59 VALUES (1008, 'Flintop', 'Bowler', 24, 6200, 190, 103);
INSERT INTO Player59 VALUES (1009, 'Hussy', 'Batsman', 29, 2900, NULL, 104);
INSERT INTO Player59 VALUES (1010, 'Murlidharan', 'Bowler', 31, 1800, 500, 102);
INSERT INTO Player59 VALUES (1011, 'Laxman', 'Batsman', 21, 5200, NULL, 101);
INSERT INTO Player59 VALUES (1112, 'Dhoni', 'Wicketkeeper', 24, 4500, NULL, 101);

INSERT INTO Country59 VALUES (101, 'India');
INSERT INTO Country59 VALUES (102, 'Shrilanka');
INSERT INTO Country59 VALUES (103, 'England');
INSERT INTO Country59 VALUES (104, 'Australia');
INSERT INTO Country59 VALUES (105, 'South Africa');

-- 3. Add new attribute NOM
ALTER TABLE Player59 ADD COLUMN NOM INT;

-- 4. Modify NOM to 75 for all
UPDATE Player59 SET NOM = 75;

-- 5. Players not taking wickets
SELECT Pname FROM Player59 WHERE Wicket IS NULL;

-- 6. Names in lower and upper case
SELECT LOWER(Pname) AS LowerCaseName, UPPER(Pname) AS UpperCaseName FROM Player59;

-- 7. Name, Runs, SR
SELECT Pname, Runs, (Runs / NOM) AS SR FROM Player59;

-- 8. Different Roles
SELECT DISTINCT Role FROM Player59;

-- 9. Players not in Tid 101,102,104
SELECT * FROM Player59 WHERE Tid NOT IN (101, 102, 104);

-- 10. Players with runs between 10000 and 20000
SELECT Pname, Runs FROM Player59 WHERE Runs BETWEEN 10000 AND 20000;

-- 11. Aggregation for Tid 101
SELECT 
    Tid,
    SUM(Runs) AS TotalRuns,
    MAX(Runs) AS MaxRuns,
    AVG(Runs) AS AvgRuns
FROM Player59
WHERE Tid = 101
GROUP BY Tid
HAVING AVG(Runs) > 1500
ORDER BY TotalRuns DESC;

-- 12. Players in each country
SELECT C.Cname, P.Pname
FROM Country59 C
LEFT JOIN Player59 P ON C.Tid = P.Tid
ORDER BY C.Cname;

-- 13. Players with same runs as Vas
SELECT Pname FROM Player59
WHERE Runs = (SELECT Runs FROM Player59 WHERE Pname = 'Vas');

-- 14. Procedure to count total players
DELIMITER $$
CREATE PROCEDURE CountPlayers()
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Player59;
    SELECT CONCAT('Total Players: ', total) AS Result;
END $$
DELIMITER ;

-- CALL CountPlayers();

-- 15. Roles in Tid 101 and 102
SELECT DISTINCT Role FROM Player59 WHERE Tid IN (101, 102);
