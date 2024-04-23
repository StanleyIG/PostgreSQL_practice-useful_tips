--  ����������� ����� GROUP BY � HAVING. �������� �������

select Country, COUNT(*) as cnt_country
from Customers
where Country <> 'Germany'
group by Country
having COUNT(*) > 10


-- ���� ����������� ���������� � �������� ����������� ������� ������ 2-�
-- ��������� Sales Representative
select ContactTitle, COUNT(*) as cnt_title
from Customers
where Country = 'Germany'
group by ContactTitle
having COUNT(*) > 2 -- ������ having ������ ��� ����� group by


-- ������� ���. ����., ����, ����� ������� �� ������ ���������, �.�. ������������� ���������.
-- ������������� �� ����������� ������� ������ 10 � ����� ������ 5
select CategoryID, COUNT(*) as cnt_product, 
min(UnitPrice) as min_price, 
max(UnitPrice) as max_price, 
AVG(UnitPrice) as avg_price, 
SUM(UnitPrice) as  sum_price
from Products
group by CategoryID
having COUNT(*) > 10 and min(UnitPrice) > 5


-- ������������� �������� �� �������,
-- �������� ����������� �������� � ������ ������,
-- ������������� �� ����������� �������� �� ������ ����� 5,
-- ������������� � ������� �����������
select Country, count(*)
from Customers
group by Country
having count(*)>5
order by count(*) 


-- ���������� � ���������� ������� �� ��������(� �������� �������)
select Country, count(*)
from Customers
group by Country
having count(*)>5
order by Country desc

-- �������� ������ ������� � ���-�� ����������� � ��� ��������. �������� ������, � ������� ��������� ������ 4 ��������. ����� ��� ������?
-- ����������� GROUP BY � HAVING.

select City, COUNT(*) as cnt_client
from Customers
group by City
having COUNT(*) > 4

-- �� ������� Products �������� ID ��������� (�ategoryID) � ������� ��������� ������� � ����������. 
-- � ����� ��������� (CategoryID) ����� ������� ������� ��������� �������?


SELECT CategoryID, AVG(UnitPrice) AS avg_price
FROM Products
GROUP BY CategoryID
ORDER BY avg_price DESC

SELECT top 1 CategoryID, AVG(UnitPrice) AS avg_price, COUNT(*) AS cnt_products
FROM Products
GROUP BY CategoryID
ORDER BY avg_price DESC

-- �������� ���� ������� (OrderDate) � ���-�� �������, ����������� � ����� 1998 ����. 
-- �������� ����, � ������� ���� ��������� 4 ������. ������� ��?
-- ��������� WHERE � HAVING.

select OrderDate, COUNT(*) as cnt_orders
from Orders
where OrderDate between '1998-03-01 00:00:00.000' and '1998-03-31 00:00:00.000'
group by OrderDate
having COUNT(*) = 4

-- ������� ����������� ����� ��������������� �������
SELECT COUNT(*) as cnt_product
FROM (
    SELECT COUNT(*) as cnt_orders
    FROM Orders
    WHERE OrderDate BETWEEN '1998-03-01 00:00:00.000' AND '1998-03-31 00:00:00.000'
    GROUP BY OrderDate
	having COUNT(*) = 4
) AS subquery;

-- ���� ����� �� � �������������� ������� MONTH ��� ��������� 
-- ����������� ������ � YEAR ��� ��������� ����������� ����
SELECT COUNT(*)
FROM (
    SELECT OrderDate
    FROM Orders
    WHERE MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 1998
    GROUP BY OrderDate
    HAVING COUNT(*) = 4
) AS SubQuery;


-- ���������� ����������� ��������� � ������� ����� � ���������� � ����������� ����� 2-��
select Country, ContactTitle, COUNT(*) as cnt_customers
from Customers
group by Country, ContactTitle
having COUNT(*) > 1
order by Country, ContactTitle

-- ��������� ��� ������������ ������
select UnitPrice * Quantity * (1-Discount)
from [Order Details]
where OrderID = 10250


-- ����� ��������� ��� ������������ ������
select sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
where OrderID = 10250

-- ����� ��������� ��� ������� ������
select OrderID, sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
group by OrderID

-- �������� �������, ������� ���������� � ������� Order Details ������� �� ����������� 
-- �������� � ���� (������� �� ����� ������) � ������ ���������� ���� (quantity) � ������� ������.

-- �������� ����� ����� ������� � ProductID = 11 � ������ ������
select OrderID, sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
where ProductID = 11
group by OrderID


-- �� ������� Order Details �������� ���������� ������ ������� (OrderID) � ��������� (�������) �������. 
-- ���������� ���-�� ���� ������ � ������ ������. ������� ������� ����� ������ 10 000?
select COUNT(*) cnt_result
from
	(select OrderID, sum(UnitPrice * Quantity * (1-Discount)) as total -- � ���������� ���������� ���� ��������� �����
	from [Order Details]                                               -- ��� �������, ������� ������������ ����� ��������� �������������� �������.
	group by OrderID
	having sum(UnitPrice * Quantity * (1-Discount)) > 10000)
	as result; -- ���-�� ���������� ������� alias � ��� ������ ����������