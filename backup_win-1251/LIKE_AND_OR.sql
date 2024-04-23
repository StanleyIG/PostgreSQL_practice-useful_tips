-- ���������� ����� WHERE. ���������� ��������� LIKE. AND � OR

-- ���������� �����
-- ��������� ��������� 
-- �������� like

select ContactName, ContactTitle
from Customers
where ContactTitle = 'Sales Manager';

select ContactName, ContactTitle
from Customers
where ContactTitle LIKE 'Sales%';

-- 'Sales%' ���� % ����� ���������� �������� ��������, ��� ����� ���� �������
-- ������ ������ ����� %

-- ������� �������� ��� ����� ���������� �� A
select ContactName, ContactTitle
from Customers
where ContactName LIKE 'A%';


-- ���� % �� ���������� �������� ��������, ��� ����� ���� �������
-- ������ ������ �� %
select ContactName, ContactTitle
from Customers
where ContactTitle LIKE '%Manager';


-- ���� �������� ���� ���������� � ���� %, �� ����� �������� ��� 
-- �������� ��� ���� �������� Sales, �� ����� � ������, � �������� ��� � �����.
select ContactName, ContactTitle
from Customers
where ContactTitle LIKE '%Sales%';


-- ������ �� ������ �� ���������� ���������� https://metanit.com/sql/sqlserver/4.6.php

-- �������� ������, ������������ �� ����� "W", � ������� ��������� �������. ����� ������ ����� ������?
select City
from Customers
where City LIKE 'W%'

-- �������� ��������, ��� ����� �������� (Phone) �������� "5555". 
-- ������� ��? ������ ������� (�������) ������ ����� ���� � ������ ������, � �������� ��� � �����.

select COUNT(*) as count_client
from Customers
where Phone LIKE '%5555%'

-- ���������� �����, �������� OR

-- ������� �������� ������� ��������� � ������ ������� ��� � ������ London
select ContactName, City, Country
from Customers
where Country = 'France'
or
City = 'London'


-- and

-- ������� ���� �������� �� 'France' � ������� ������� ���������� �� ����� L
select ContactName, City, Country
from Customers
where Country = 'France'
and
City like 'L%'

-- ������� ������ ���������� ������ 10, �� ������ 15
select ProductName, UnitPrice
from Products
where UnitPrice > 10 and UnitPrice < 15;


-- between

-- between ��� ����������� ������� �������� �� 10 �� 15
select ProductName, UnitPrice
from Products
where UnitPrice between 10 and 15;

select OrderID, OrderDate 
from Orders
where OrderDate between '1997-07-09 00:00:00.000' and '1997-07-12 00:00:00.000'


-- ��������� and ��� or
-- � ���������� ������ ����� �������� and ������ ��������� �� �������� ���� ProductID, UnitPrice
-- � ����� ���������� �������� or � ����� ��������� �������� ��� ����� �������
select ProductID, UnitPrice
from Products
where ProductID = 1 or ProductID = 2 and UnitPrice = 19

-- �� ���� ���������� ProductID = 1 or ProductID = 2 � ������, �� � ����������
-- ����� �������� or
-- ��������� ProductID ������� ����� ���������� UnitPrice ����� �������� and
select ProductID, UnitPrice
from Products
where (ProductID = 1 or ProductID = 2) and UnitPrice = 19

-- �������� ���������� � �������, ������� ��������� � ������ ��� � �������� � 
-- ��������� "Marketing Assistant". ��� ����� ����� ��������?
select ContactName
from Customers
where Country = 'USA' and ContactTitle = 'Marketing Assistant'

-- �������� ��������, ������� ����� ������ 100 �������� ��� ���������� Chai. 
-- ������� ��� ������: �������� �������� � ���� ��������. ������� ��������� ����� ������?

-- ������� ���.������� � ����� ������������
SELECT
    ProductName,
    UnitPrice,
    (SELECT COUNT(*)
     FROM Products
     WHERE UnitPrice > 100 OR ProductName = 'Chai') as total
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'

-- �� ����������� ��� �������
SELECT UnitPrice, ProductName, COUNT(*) as item_prod
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'
GROUP BY ProductName, UnitPrice


-- ������ ������
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'


-- � �������������� ������� ������� COUNT OVER (PARTITION BY) PARTITION BY ��������� ��� �� �������
-- �� ����. ����. � ��������
SELECT
    ProductName,
    UnitPrice,
    COUNT(*) OVER (PARTITION BY ProductName, UnitPrice) as item,
    COUNT(*) OVER () as total
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai';


-- ������� ��-�� ��� � ����, �� � ������� ��������� p1 � p2, 
-- �.�. � ������� item �� ��������� ����� �� ProductName � UnitPrice
-- ����� �� ������ ������ item �������� �� ������� � ���� �� ��������� ��������, ��� ����������
SELECT
    ProductName,
    UnitPrice,
    (SELECT COUNT(*)
		FROM Products
		WHERE UnitPrice > 100 OR ProductName = 'Chai') as total_number_products,
	(SELECT COUNT(*)
		FROM Products AS p2
		WHERE (p2.UnitPrice > 100 OR p2.ProductName = 'Chai') 
		AND p2.ProductName = p1.ProductName 
		AND p2.UnitPrice = p1.UnitPrice) as item
FROM Products AS p1
WHERE UnitPrice > 100 OR ProductName = 'Chai';




