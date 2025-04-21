# MySQL Queries for Employee and Department Database

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
(7934, 'Miller', 'Clerk', 7782, '1982-01-23', 1300, NULL, 10);
```

## 3. Add new attribute company in the employee table with char(4)
```sql
ALTER TABLE Employee ADD company CHAR(4);
```

## 4. List the employee name, who are not eligible for commission
```sql
SELECT ENAME 
FROM Employee 
WHERE COMM IS NULL OR COMM = 0;
```

## 5. Display names of employees in lower and upper case
```sql
SELECT LOWER(ENAME) AS LowerCaseName, UPPER(ENAME) AS UpperCaseName 
FROM Employee;
```

## 6. List the name, salary, and PF amount of all employees (PF is 10% of salary)
```sql
SELECT ENAME, SAL, SAL * 0.10 AS PF 
FROM Employee;
```

## 7. List the Different designations available in the employee table
```sql
SELECT DISTINCT JOB 
FROM Employee;
```

## 8. List the Employee details not belonging to the department 10, 30, 40
```sql
SELECT * 
FROM Employee 
WHERE DEPTNO NOT IN (10, 30, 40);
```

## 9. List the Employee Name and Salary, whose salary is in the range 1000 and 2000
```sql
SELECT ENAME, SAL 
FROM Employee 
WHERE SAL BETWEEN 1000 AND 2000;
```

## 10. List the total salary, highest salary and average salary of employees job wise for department no 20, display only rows with average salary > 1500, ordered by total salary descending
```sql
SELECT JOB, 
       SUM(SAL) AS TotalSalary, 
       MAX(SAL) AS HighestSalary, 
       AVG(SAL) AS AverageSalary
FROM Employee
WHERE DEPTNO = 20
GROUP BY JOB
HAVING AVG(SAL) > 1500
ORDER BY TotalSalary DESC;
```

## 11. Display the list of employees working in each department (including departments with no employees)
```sql
SELECT d.DEPTNO, d.DNAME, e.ENAME
FROM Department d
LEFT JOIN Employee e ON d.DEPTNO = e.DEPTNO
ORDER BY d.DEPTNO;
```

## 12. Display the name of employee having salary same as employee FORD
```sql
SELECT e1.ENAME
FROM Employee e1
WHERE e1.SAL = (SELECT SAL FROM Employee WHERE ENAME = 'Ford')
AND e1.ENAME != 'Ford';
```

## 13. List names of employees along with Manager Name, who joined before their manager
```sql
SELECT e.ENAME AS EmployeeName, m.ENAME AS ManagerName, e.HIREDATE AS EmpHireDate, m.HIREDATE AS MgrHireDate
FROM Employee e
JOIN Employee m ON e.MGR = m.EMPNO
WHERE e.HIREDATE < m.HIREDATE;
```

## 14. Write PL/SQL program to find factorial of 5
```sql
DELIMITER //
CREATE PROCEDURE CalculateFactorial(IN num INT, OUT result BIGINT)
BEGIN
    DECLARE i INT;
    SET result = 1;
    SET i = 1;
    
    WHILE i <= num DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- To call the procedure for factorial of 5:
CALL CalculateFactorial(5, @factorial);
SELECT @factorial AS FactorialOf5;
```

## 15. Increase the salary of employees working as Manager by 5%
```sql
UPDATE Employee 
SET SAL = SAL * 1.05 
WHERE JOB = 'Manager';
```