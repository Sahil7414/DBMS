# MySQL Queries for Customer and Branch Database (Example 3b)

## 1. Create Customer and Branch tables
```sql
CREATE TABLE Branch (
    Branchcode INT(2) PRIMARY KEY,
    BranchName VARCHAR(20)
);

CREATE TABLE Customer (
    Acno CHAR(6) PRIMARY KEY,
    ename VARCHAR(20),
    estreet VARCHAR(20),
    ceity VARCHAR(20),
    Balamt DECIMAL(9,2),
    Loanno CHAR(4),
    Loanamt DECIMAL(9,2),
    Branchcode INT(2),
    Assets INT(4),
    FOREIGN KEY (Branchcode) REFERENCES Branch(Branchcode)
);
```

## 2. Insert all tuples in both tables
```sql
-- Insert into Branch table
INSERT INTO Branch (Branchcode, BranchName) VALUES
(10, 'Brighton'),
(20, 'Downtown'),
(30, 'Mianus'),
(40, 'North Town');

-- Insert into Customer table
INSERT INTO Customer (Acno, ename, estreet, ceity, Balamt, Loanno, Loanamt, Branchcode, Assets) VALUES
('A-101', 'Adams', 'Spring', 'Pittsfield', 9000.00, 'L-1', 5000.00, 10, NULL),
('A-201', 'Brooks', 'Senator', 'Brooklyn', 8000.00, NULL, NULL, 20, NULL),
('A-301', 'Curry', 'North', 'Rye', 4500.00, 'L-2', 2000.00, 10, NULL),
('A-401', 'Glenn', 'Sand Hill', 'Woodside', 8900.00, NULL, NULL, 20, NULL),
('A-501', 'Jones', 'Main', 'Harrison', 3784.00, NULL, NULL, 10, NULL),
('A-601', 'Lindsay', 'Park', 'Pittsfield', 7893.00, 'L-3', 5700.00, 30, NULL),
('A-701', 'Smith', 'North', 'Rye', 4532.00, NULL, NULL, 10, NULL),
('A-801', 'Turner', 'Putnam', 'Stanford', 4981.00, NULL, NULL, 30, NULL);
```

## 3. Modify the width of assets to number(6) in customer table
```sql
ALTER TABLE Customer MODIFY COLUMN Assets INT(6);
```

## 4. Modify the Assets attribute value by 25% of balamt of all customers
```sql
UPDATE Customer SET Assets = Balamt * 0.25;
```

## 5. List the names of customer of branch code 10 and stays in Rye city
```sql
SELECT ename 
FROM Customer 
WHERE Branchcode = 10 AND ceity = 'Rye';
```

## 6. Display name of the customer which contains 'N' character in customer name
```sql
SELECT ename 
FROM Customer 
WHERE ename LIKE '%N%' OR ename LIKE '%n%';
```

## 7. List the acno, Customer name, balamt, and Interest of all customers (interest is 7% of balamt)
```sql
SELECT Acno, ename, Balamt, Balamt * 0.07 AS Interest 
FROM Customer;
```

## 8. List the Different customer street present in customer table
```sql
SELECT DISTINCT estreet 
FROM Customer;
```

## 9. List the Names of customer ending with 'S'
```sql
SELECT ename 
FROM Customer 
WHERE ename LIKE '%S' OR ename LIKE '%s';
```

## 10. List the Customer Name and balamt, whose balamt is in the range of 3000 and 5000
```sql
SELECT ename, Balamt 
FROM Customer 
WHERE Balamt BETWEEN 3000 AND 5000;
```

## 11. List the total balamt, highest balamt and average balamt of customer branch code wise for branch code 20 and display only those rows having average balamt greater than 1500, arranged in descending order of total balamt
```sql
SELECT Branchcode, 
       SUM(Balamt) AS TotalBalamt, 
       MAX(Balamt) AS HighestBalamt, 
       AVG(Balamt) AS AverageBalamt
FROM Customer
WHERE Branchcode = 20
GROUP BY Branchcode
HAVING AVG(Balamt) > 1500
ORDER BY TotalBalamt DESC;
```

## 12. Display the acno, customer name, branch code, Branch name for all customers
```sql
SELECT c.Acno, c.ename, c.Branchcode, b.BranchName
FROM Customer c
JOIN Branch b ON c.Branchcode = b.Branchcode;
```

## 13. List the names of customer who have account in the same branch as Adams
```sql
SELECT c.ename
FROM Customer c
WHERE c.Branchcode = (SELECT Branchcode FROM Customer WHERE ename = 'Adams')
AND c.ename != 'Adams';
```

## 14. Write PL/SQL program to find area of circle for radius 5
```sql
DELIMITER //
CREATE PROCEDURE CalculateCircleArea(IN radius DECIMAL(10,2), OUT area DECIMAL(10,2))
BEGIN
    SET area = PI() * radius * radius;
END //
DELIMITER ;

-- To call the procedure for radius 5:
CALL CalculateCircleArea(5, @circle_area);
SELECT @circle_area AS AreaOfCircle;
```

## 15. Display the different City present in Branch code 20 and 30
```sql
SELECT DISTINCT ceity 
FROM Customer 
WHERE Branchcode IN (20, 30);
```