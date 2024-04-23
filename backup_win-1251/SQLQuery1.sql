

-- �������� �� �� ������� Products
--select *
--from Products


-- ����� �������, ������ ��������� ���������� � ������������ 
-- ��������� � ����� 14, ������� �������� ���������, �������� 
-- ��������, ���� �������� � ����� ����������.
SELECT c.CategoryName, p.ProductName, p.UnitPrice, s.City
FROM Products AS p
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
JOIN Categories AS c ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 1
and p.UnitPrice = 14


-- ���� �������� nul
select * 
from
Customers
where Region is null

-- ���� �������� �� null
select * 
from
Customers
where Region is not null

-- ������� �� ����� ��������� �������� � ����
 select * from Products where ProductName not in ('Tofu','Konbu','Chang')

-- ������� ������ ������ � ���������� ���������� � ���� ProductName 
 select * from Products where ProductName in ('Tofu','Konbu','Chang')


 -- ���� SQL-������ ��������� ��� ������ �� ������� Products, ��� �������� 
 -- � ������� ProductName ������ (� ���������� �������) ��� ������ 'Ikura'. 
 -- ����� ��������� ������������ � ������������������ ������� (�� ��������).
 select *
from Products
where ProductName < 'Ikura'

-- ����������� ������� ���������� ������ 100
select COUNT(*)
from Products
where UnitPrice > 100

-- ������� �������� �� �������
-- ����� ���������� �����

SELECT
    Country,
    CompanyName,
    ContactName,
    (SELECT COUNT(*) FROM Customers WHERE Country = 'Spain') AS total_umbe
FROM Customers
where Country = 'Spain'

select COUNT(*) as spain_count
FROM Customers
where Country = 'Spain'









