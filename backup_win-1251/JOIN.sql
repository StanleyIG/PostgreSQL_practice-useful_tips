-- ������� ��������� ���� � ������� ����. ���� ������ � ��


select t1.*, t2.*
from Products t1 
inner join Categories t2
on t1.CategoryID = t2.CategoryID


-- ������������� ����� ���������� ������� ��� ������� ����������� ������ � ����������� ����� ������� �� ��������.
select t2.City, t2.ContactName , COUNT(*) as cnt_orders, COUNT(distinct t2.CustomerID)
from Orders as t1
inner join Customers as t2
on t1.CustomerID = t2.CustomerID
where Country = 'Germany'
group by City, ContactName
order by COUNT(*)


-- �������� �������� ������ ����� ������� �� ������� ������ �� ��������� 1
select ProductName, sum(t1.UnitPrice * t1.Quantity * (1- t1.Discount))
from [Order Details] as t1
inner join Products as t2
on t1.ProductID = t2.ProductID
where CategoryID = 1
group by ProductName


select *
from [Order Details] as t1
inner join Products as t2
on t1.ProductID = t2.ProductID
where CategoryID = 1


-- ���������� ���-�� �������, ������� ���� ��������� ����������� Andrew Fuller.
select COUNT(*) as cnt_orders
from Orders as t1
inner join Employees as t2
on t1.EmployeeID = t2.EmployeeID
-- where FirstName = 'Andrew' and LastName = 'Fuller'
where FirstName like 'Andrew' and LastName like 'Fuller'
group by t1.EmployeeID

select *
from Employees

select *
from Orders

-- ���������� ��������� ������� (���������) �� �������, ������� ���� ��������� � 1997 ����. ����� ��������� �� ������ �����.
select  year(OrderDate) as yer, round(sum(t2.UnitPrice * t2.Quantity * (1- t2.Discount)), 0) as total_revenue
from Orders as t1
inner join [Order Details] as t2
on t1.OrderID = t2.OrderID
where year(OrderDate) = 1997
group by YEAR(OrderDate)

select round(sum(t2.UnitPrice * t2.Quantity * (1- t2.Discount)), 0) as total_revenue
from Orders as t1
inner join [Order Details] as t2
on t1.OrderID = t2.OrderID
where year(OrderDate) = 1997
group by YEAR(OrderDate)


select round(sum(t2.UnitPrice * t2.Quantity * (1- t2.Discount)), 0) as total_revenue
from Orders as t1
inner join [Order Details] as t2
on t1.OrderID = t2.OrderID
where OrderDate between '1997-01-01 00:00:00.000' and '1997-01-31 00:00:00.000'

-- ������� ������� ��� ������� ������ ��� ������������� 
-- ������������ ������� SUM, ������� ���������� ����� ������ ������������ �� ������������ ����
-- ���� ��������� ����� ����� �� �������
SELECT
  t2.UnitPrice * t2.Quantity * (1 - t2.Discount) AS RevenueForSingleRow
FROM
  Orders AS t1
INNER JOIN
  [Order Details] AS t2 ON t1.OrderID = t2.OrderID
WHERE
  YEAR(OrderDate) = 1997


-- �������� �������� ��������� � ���-�� ���������, ������� ������ � ���������. 
-- ����������� �������� ��������� � ���-�� ��������� � ����������.
select t2.CategoryName, COUNT(*) as cnt_products
from Products as t1
inner join Categories as t2
on t1.CategoryID = t2.CategoryID
group by t2.CategoryName

select t1.CategoryID, COUNT(*) as cnt_products
from Products as t1
inner join Categories as t2
on t1.CategoryID = t2.CategoryID
where CategoryName = 'Seafood'
group by t1.CategoryID


-- �������� ����� �������� ��� ������ ������� ��������� Robert King
select distinct t3.ContactName
from Orders as t1
inner join Employees as t2
on t1.EmployeeID = t2.EmployeeID
inner join Customers as t3
on t1.CustomerID = t3.CustomerID
where t2.FirstName = 'Robert' and t2.LastName = 'King'


--�������� ��� � ������� ����������, ������� ������� ����� ������� Francisco Chang.
select t2.FirstName, t2.LastName
from Orders as t1
inner join Employees as t2
on t1.EmployeeID = t2.EmployeeID
inner join Customers as t3
on t1.CustomerID = t3.CustomerID
where t3.ContactName = 'Francisco Chang'





