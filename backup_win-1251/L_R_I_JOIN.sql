-- LEFT JOIN � ��������� ���� JOIN-��
-- �������� �������� � ����-�� ������� � ������� �����������
select ContactName, COUNT(distinct t2.OrderID)
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
group by ContactName
order by COUNT(OrderID)

-- �������� ����������� ���������� ��������� � ������� �� ����� �������
select COUNT(distinct t1.CustomerID)
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
where OrderID is null


-- � ����� ������� ��������� �������, ������� �� ��������� �� ������ ������? 
-- ����������� LEFT JOIN ��� ������� ������. ������� ������ ���� � �����-�����. 

select t1.City
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
where OrderID is null

-- ��������� ��� RIGHT JOIN � FULL JOIN ����� �� ��� ��� INNER JOIN ��� LEFT JOIN. 
-- � ��� CROSS JOIN ��� ������������� ��������� ����� �� �����. 
-- ��������� ������ ������: select * from Categories cross join Products

select * from Categories cross join Products


-- ����������� ���������� ������ � ������� UNION � UNION ALL

-- ������� ������ ���������� ���������� �� ������ �������� � �����������
select Title
from Employees
union
select ContactTitle
from Customers

-- ������� ��������� ������� ����������� � ������ �������, �� ���������� �� ������
select Title
from Employees
except 
select ContactTitle
from Customers

-- ������� ��������� ������� ����������� � � ������ � �� ������ �������
select Title
from Employees
intersect
select ContactTitle
from Customers


-- ��� ������ ��������� UNION ����� ���������� ������, ������� ������� �� ������ ���������� ��������. 
-- ��������� SQL-������� ���� � �������� ���������� ���������� �����.

-- 1)

select Country, Title
from Employees
union all
select Country, ContactTitle
from Customers

-- 2)

select Country, Title
from Employees
union 
select Country, ContactTitle
from Customers

-- ���������� ������ ������� ����������� � ������ ������� �������� � ���� ������. 
-- ������� ���������� ������� ���������� � ����������?

select City
from Customers
union 
select City
from Employees

select COUNT(*) as cnt_city
from
	(select City
	from Customers
	union 
	select City
	from Employees
	) as subquary


-- ����������
-- ������� ����������� ���� � ������������� ������� ������ 2-��
select COUNT(*)
from
	(select OrderDate, COUNT(*) as cnt
	from Orders
	group by OrderDate
	having count(*) > 2) as total1

-- ������ �2

select CustomerID
from Customers
where Country = 'USA'

select *
from Orders
where CustomerID in ('VINET', 'TOMSP', 'HANAR')

-- ������� ������ ������� � ������� ������� ��������� � USA
select *
from Orders
where CustomerID in (select CustomerID
					from Customers
					where Country = 'USA')


-- ������� ���� ������� �� ������ ������ � ������� ��������

select Country, 
sum(UnitPrice * Quantity * (1 - Discount)) /
									(select sum(UnitPrice * Quantity * (1 - Discount))
									 from [Order Details]) * 100
from
[Order Details] as t1
inner join Orders as t2
on t1.OrderID = t2.OrderID
inner join Customers as t3 
on t2.CustomerID = t3.CustomerID
group by Country
order by sum(UnitPrice * Quantity * (1 - Discount)) /
									(select sum(UnitPrice * Quantity * (1 - Discount))
									 from [Order Details]) * 100 desc

-- ������� ������ � ����� ������� ����� �������
select top 1 Country, 
sum(UnitPrice * Quantity * (1 - Discount)) /
									(select sum(UnitPrice * Quantity * (1 - Discount))
									 from [Order Details]) * 100
from
[Order Details] as t1
inner join Orders as t2
on t1.OrderID = t2.OrderID
inner join Customers as t3 
on t2.CustomerID = t3.CustomerID
group by Country
order by sum(UnitPrice * Quantity * (1 - Discount)) /
									(select sum(UnitPrice * Quantity * (1 - Discount))
									 from [Order Details]) * 100 desc


-- � ���� ������ �������������� ������� ��������� ��������. ����� ��� ��������� ������� ����� �������� �� ����������� ��������.
-- https://info-comp.ru/obucheniest/747-subqueries-in-t-sql.html

-- https://learn.microsoft.com/ru-ru/sql/relational-databases/performance/subqueries?view=sql-server-ver15

-- �������� ������ � ���-�� ��������, ������� ��������� � ���� �������. 
-- �������� ������ ������ � ����������� �������� ����� ������. ����� � ������� ���������� ������� ���������� ���������� ����� �����.

-- �����: ������� Alias-� ��� ���������� ������� � �������, ������� �������� ����������� 
-- ���������� ������������ �������, ����� ��������� ������ �� ���������.
select COUNT(*) cnt_country
from
	(select Country, COUNT(*) cnt_customers
	from Customers
	group by Country
	having COUNT(*) > 1) as subqary


-- �������� ID �������� � ���-�� �������, ������� ��������� �������. 
-- �������� ������ ID �������� � ����������� ������� ����� 10. ����� � ������� ���������� ������� ���������� ���������� ����� ��������.

-- �����: ������� Alias-� ��� ���������� ������� � �������, ������� �������� �����������
-- ���������� ������������ �������, ����� ��������� ������ �� ���������.

select COUNT(*) as cnt_customers
from
	(select CustomerID, COUNT(*) as cnt_orders
	from Orders
	group by CustomerID
	having COUNT(*) > 10) as subquary


-- �������� ������, ������� ��������� � CategoryID =1. ����������� ���� SQL-������ ��� ��������� ��� ����, ����� ��������� 
-- ����� ������� �� �������, ������� ��������� � CategoryID = 1. ����� ��������� �� ������ �����.

-- ����������:  ������ ������� �� ������� �2 �� ���������� �����.
select * 
from Products
where CategoryID = 1
-----


select t2.ProductID
from Products as t1
inner join [Order Details] as t2
on t1.ProductID = t2.ProductID
where CategoryID = 1

select ProductID
from Products
where CategoryID = 1

select round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details]
where ProductID in (select t2.ProductID
		from Products as t1
		inner join [Order Details] as t2
		on t1.ProductID = t2.ProductID
		where CategoryID = 1)


select round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details]
where ProductID in (select ProductID
					from Products
					where CategoryID = 1)





-- �������� �� ������ 2-�� ������
-- ���������� ���������� �������, � ������� ������������ ����� Chocolade.

select ProductID 
from Products
where ProductName = 'Chocolade'

select COUNT(*) 
from [Order Details]
where ProductID in (select ProductID 
					from Products
					where ProductName = 'Chocolade')

select COUNT(distinct OrderID)
from [Order Details] as t1
inner join Products as t2
on t1.ProductID = t2.ProductID
where ProductName = 'Chocolade'

-- ���������� ����� �������, ������� �������� ������ ��������� Confections. ����� ��������� �� ������ �����.
select round(sum(UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details]
where ProductID in (select ProductID
					from Products as t1
					inner join Categories as t2
					on t1.CategoryID = t2.CategoryID
					where CategoryName = 'Confections')


select round(sum(t1.UnitPrice * t1.Quantity * (1 - t1.Discount)), 0)
from [Order Details] as t1
inner join Products as t2
on t1.ProductID = t2.ProductID 
inner join Categories as t3
on t2.CategoryID = t3.CategoryID
where CategoryName = 'Confections'

-- ���������� ������� �� ������ ���������. ����� ��������� �������� ����� ������� �������?
select top 1 CategoryName, round(sum(t2.UnitPrice * t2.Quantity * (1 - t2.Discount)), 0) as total
from Products as t1
inner join [Order Details] as t2
on t1.ProductID = t2.ProductID
inner join Categories as t3
on t1.CategoryID = t3.CategoryID
group by CategoryName
order by total desc


-- ������ Simon Crowther ����������, ��� ������� ����� 29 ������ 1998 ����, �� ����� ������ �������� - ����� ������� �����������. 
-- ������� ��� ���������� �� ����������, ������� ������� ���� �����, ����� ��������� � ���. ��� ����� ����� ����������?

select * 
from Employees

select CustomerID
from Customers
where ContactName = 'Simon Crowther'


select t3.FirstName, T3.LastName, t3.HomePhone
from Orders as t1
inner join Customers as t2
on t1.CustomerID = t2.CustomerID
inner join Employees as t3
on t1.EmployeeID = t3.EmployeeID
where OrderDate = '1998-04-29 00:00:00.000'
and ContactName = 'Simon Crowther'


-- �������� ������ �������� (Shipcity) � ���-�� �������, ������� ���� ��������� � ��� ������ � 1997 ����. 
-- �������� ������ ������ � ����������� ������� ������ 5. 
-- ����� � ������� ���������� ������� ���������� ���������� ��������� �������.

select COUNT(*)
from
	(select ShipCity, COUNT(*) as cnt_orders
	from Orders
	where OrderDate between '1997-01-01 00:00:00.000' and '1997-12-31 00:00:00.000'
	group by ShipCity
	having COUNT(*) > 5) as subquary
