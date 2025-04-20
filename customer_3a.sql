# MySQL Queries for Customer and Branch Database

## 1. Create Customer and Branch tables
```sql
CREATE TABLE Branch (
    Branchcode INT(2) PRIMARY KEY,
    BranchName VARCHAR(20)
);

CREATE TABLE Customer (
    Acno CHAR(6) PRIMARY KEY,
    ename VARCHAR(20),
    cstreet VARCHAR(20),
    ccity VARCHAR(20),
    Balamt DECIMAL(9,2),
    Loanno CHAR(4),
    Loanamt DECIMAL(9,2),
    Branchcode INT(2),
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
INSERT INTO Customer (Acno, ename, cstreet, ccity, Balamt, Loanno, Loanamt, Branchcode) VALUES
('A-101', 'Adams', 'Spring', 'Pittsfield', 9000.00, 'L-1', 5000.00, 10),
('A-201', 'Brooks', 'Senator', 'Brooklyn', 8000.00, NULL, NULL, 20),
('A-301', 'Curry', 'North', 'Rye', 4500.00, 'L-2', 2000.00, 10),
('A-401', 'Glenn', 'Sand Hill', 'Woodside', 8900.00, NULL, NULL, 20),
('A-501', 'Jones', 'Main', 'Harrison', 3784.00, NULL, NULL, 10),
('A-601', 'Lindsay', 'Park', 'Pittsfield', 7893.00, 'L-3', 5700.00, 30),
('A-701', 'Smith', 'North', 'Rye', 4532.00, NULL, NULL, 10),
('A-801', 'Turner', 'Putnam', 'Stanford', 4981.00, NULL, NULL, 30);
```

## 3. Add new attribute Assets in customer table with number (4)
```sql
ALTER TABLE Customer ADD Assets INT(4);
```

## 4. Modify the Assets attribute value by 25% of balamt of all customers
```sql
UPDATE Customer SET Assets = Balamt * 0.25;
```

## 5. List the Customers names who have not taken loan
```sql
SELECT ename 
FROM Customer 
WHERE Loanno IS NULL;
```

## 6. Display names of customer in lower and upper case
```sql
SELECT LOWER(ename) AS LowerCaseName, UPPER(ename) AS UpperCaseName 
FROM Customer;
```

## 7. List the acno, Customer name, balamt, and Interest of all customers (interest is 7% of balamt)
```sql
SELECT Acno, ename, Balamt, Balamt * 0.07 AS Interest 
FROM Customer;
```

## 8. List the Different City present in customer table
```sql
SELECT DISTINCT ccity 
FROM Customer;
```

## 9. List the Customer details not belonging to the Branch code 10, 20
```sql
SELECT * 
FROM Customer 
WHERE Branchcode NOT IN (10, 20);
```

## 10. List the Customer Name and balamt, whose balamt is in the range of 2000 and 5000
```sql
SELECT ename, Balamt 
FROM Customer 
WHERE Balamt BETWEEN 2000 AND 5000;
```

## 11. List the total balamt, highest balamt and average balamt of customer branch code wise for the branch code 30 and display only those rows having average balamt greater than 1500 and arrange the result in Descending order of the total balamt
```sql
SELECT Branchcode, 
       SUM(Balamt) AS TotalBalamt, 
       MAX(Balamt) AS HighestBalamt, 
       AVG(Balamt) AS AverageBalamt
FROM Customer
WHERE Branchcode = 30
GROUP BY Branchcode
HAVING AVG(Balamt) > 1500
ORDER BY TotalBalamt DESC;
```

## 12. Display the list of Customer in each Branch. Display the Branch information even if no customer is belonging to that Branch
```sql
SELECT b.Branchcode, b.BranchName, c.ename
FROM Branch b
LEFT JOIN Customer c ON b.Branchcode = c.Branchcode
ORDER BY b.Branchcode;
```

## 13. Display the names of Customer whose stays at same street and city as that of 'Smith'
```sql
SELECT c1.ename
FROM Customer c1
JOIN Customer c2 ON c1.cstreet = c2.cstreet AND c1.ccity = c2.ccity
WHERE c2.ename = 'Smith' AND c1.ename != 'Smith';
```

## 14. Write PL/SQL program to find factorial of 7
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

-- To call the procedure for factorial of 7:
CALL CalculateFactorial(7, @factorial);
SELECT @factorial AS FactorialOf7;
```

## 15. Display the different City present in Branch code 10 and 30
```sql
SELECT DISTINCT ccity 
FROM Customer 
WHERE Branchcode IN (10, 30);
```