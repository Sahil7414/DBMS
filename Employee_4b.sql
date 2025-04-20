# MySQL Queries for Employee and Department Database (Example 4b)

## 1. Create Employee and Department tables
```sql
CREATE TABLE Department (
    DEPTNO INT(2) PRIMARY KEY,
    DNAME VARCHAR(20),
    LOC VARCHAR(10)
);

CREATE TABLE Employee (
    EMPNO INT(4) PRIMARY KEY,
    ENAME VARCHAR(20),
    JOB VARCHAR(20),
    MGR INT(4),
    HIREDATE DATE,
    SAL DECIMAL(9,2),
    COMM DECIMAL(9,2),
    DEPTNO INT(2),
    FOREIGN KEY (DEPTNO) REFERENCES Department(DEPTNO)
);
```

## 2. Insert all tuples in both tables
```sql
-- Insert into Department table
INSERT INTO Department (DEPTNO, DNAME, LOC) VALUES
(10, 'Accounting', 'New York'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Operations', 'Boston');

-- Insert into Employee table
INSERT INTO Employee (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7369, 'Smith', 'Clerk', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'Allen', 'Salesman', 7698, '1981-02-20', 1600, NULL, 30),
(7521, 'Ward', 'Salesman', 7698, '1981-02-22', 1250, 300, 30),
(7566, 'Jones', 'Manager', 7839, '1981-04-02', 2975, 500, 20),
(7654, 'Martin', 'Salesman', 7698, '1981-09-28', 1250, NULL, 30),
(7698, 'Blake', 'Manager', 7839, '1981-05-01', 2850, 1400, 30),
(7782, 'Clark', 'Manager', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'Scott', 'Analyst', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'King', 'President', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'Turner', 'Salesman', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'Adams', 'Clerk', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'James', 'Clerk', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'Ford', 'Analyst', 7566, '1981-12-04', 3000, NULL, 20),
(7934, 'Miller', 'Clerk', 7782, '1982-01-23', 1300, NULL, 10),
(7777, 'Xyz', 'Clerk', 7782, '1983-01-23', 578, NULL, 50);
```

## 3. Add attribute grade to employee table
```sql
ALTER TABLE Employee ADD grade VARCHAR(2);
```

## 4. List the names of clerk employees working in department 20
```sql
SELECT ENAME 
FROM Employee 
WHERE JOB = 'Clerk' AND DEPTNO = 20;
```

## 5. Display name of the department and length of each department name
```sql
SELECT DNAME, LENGTH(DNAME) AS NameLength 
FROM Department;
```

## 6. List the name, salary, and HRA amount of all employees (HRA is 20% of salary)
```sql
SELECT ENAME, SAL, SAL * 0.20 AS HRA 
FROM Employee;
```

## 7. List the Different department nos in the employee table
```sql
SELECT DISTINCT DEPTNO 
FROM Employee;
```

## 8. List the Names of Employee starting with 'M'
```sql
SELECT ENAME 
FROM Employee 
WHERE ENAME LIKE 'M%';
```

## 9. List the Employee Name and hire date who joined between 30th June 81 and 31st Dec 81
```sql
SELECT ENAME, HIREDATE 
FROM Employee 
WHERE HIREDATE BETWEEN '1981-06-30' AND '1981-12-31';
```

## 10. List total salary, highest salary and average salary of employees job wise for dept 30, with avg salary > 1000, ordered by total salary ascending
```sql
SELECT JOB, 
       SUM(SAL) AS TotalSalary, 
       MAX(SAL) AS HighestSalary, 
       AVG(SAL) AS AverageSalary
FROM Employee
WHERE DEPTNO = 30
GROUP BY JOB
HAVING AVG(SAL) > 1000
ORDER BY TotalSalary ASC;
```

## 11. Display list of all employees with no corresponding department name and location
```sql
SELECT e.*
FROM Employee e
LEFT JOIN Department d ON e.DEPTNO = d.DEPTNO
WHERE d.DEPTNO IS NULL;
```

## 12. List names of employees belonging to department of JONES
```sql
SELECT e.ENAME
FROM Employee e
WHERE e.DEPTNO = (SELECT DEPTNO FROM Employee WHERE ENAME = 'Jones')
AND e.ENAME != 'Jones';
```

## 13. List names of employees along with Manager Name
```sql
SELECT e.ENAME AS EmployeeName, m.ENAME AS ManagerName
FROM Employee e
LEFT JOIN Employee m ON e.MGR = m.EMPNO;
```

## 14. Write PL/SQL program to generate table of 5
```sql
DELIMITER //
CREATE PROCEDURE GenerateTableOf5()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result INT;
    
    WHILE i <= 10 DO
        SET result = 5 * i;
        SELECT CONCAT('5 × ', i, ' = ', result) AS MultiplicationTable;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- To call the procedure:
CALL GenerateTableOf5();
```

## 15. Give Rs 500 as commission to all employees
```sql
UPDATE Employee 
SET COMM = 500 
WHERE COMM IS NULL OR COMM = 0;
```