-- ��������� CASE
use Northwind;

select ContactName, City, Region, case when Region is null then 'not defiened' else Region end as new_column
from Customers

-- ������� ������� ����������� �� �������
select ContactName, Country, case when country in ('Argentina', 'Brazil') then 'South America'
                                  when country in ('Argentina', 'Brazil') then 'North America'
								  when country in ('Spain', 'Portugal') then 'Europe' end as Continent
from Customers
where Country in ('Argentina', 'Brazil', 'Argentina', 'Brazil', 'Spain', 'Portugal')


-- ����������� �������� � ������� ������� ����������
select continent, COUNT(ContactName)
from
	(
	select ContactName, Country, case when country in ('Argentina', 'Brazil') then 'South America'
									  when country in ('Argentina', 'Brazil') then 'North America'
									  else 'Europe' end as continent
	from Customers
	where Country in ('Argentina', 'Brazil', 'Argentina', 'Brazil', 'Spain', 'Portugal')) as table1
group by continent


-- ���� ��� ������� ������� ������� revenue_group, � ������� ��������������� �������� ������� �� ������� ������
-- � 0 �� 999, �� 1000 �� 4999 � �� 5000 � ����
select orderid, 
sum(UnitPrice*Quantity*(1-Discount)) as Revenue, 
case when sum(UnitPrice*Quantity*(1-Discount)) < 1000 then '0-999'
         when sum(UnitPrice*Quantity*(1-Discount)) < 5000 then '1000-4999'
         else '5000 and >' end as revenue_group
from [Order Details] 
group by orderid


select orderid, 
sum(UnitPrice*Quantity*(1-Discount)) as Revenue, 
case when sum(UnitPrice*Quantity*(1-Discount)) between 1 and 999 then '0-999'
         when sum(UnitPrice*Quantity*(1-Discount)) between 1000 and 4999 then '1000-4999'
         when sum(UnitPrice*Quantity*(1-Discount)) >=5000 then '5000 and >' end as revenue_group
from [Order Details] 
group by orderid


-- �������� ����� �����������, ������ � �������. � ������� ��������� CASE �������� ����� ��������� 
-- ������� Region � �������� ������ �������� NULL �� �������� 'not defined'. 
-- � �������� ����������� ������ ����� 'not defined'?
select Region, COUNT(FirstName)
from
	(select FirstName, Country, case when Region is null then 'not defiened' else Region end as Region
	from Employees) as subquary
group by Region 


-- �������� �����, ������� ����������� � ��������� (TitleOfCourtesy). 
-- ����� � ������� ��������� CASE �������� ��������� ������� Gender. 
-- ���� ��������� Ms. ��� Mrs., �� gender - 'women', � ���� ��������� Mr. ��� Dr., �� gender - 'men'. 
-- ����� � ������� ���������� ������� ���������� ���-�� ������ � ������. ������� ����������� �������� ����?
select gender, COUNT(*)
from
	(select FirstName, LastName, TitleOfCourtesy, case when TitleOfCourtesy like 'Ms%' then 'women'
													   when TitleOfCourtesy like 'Mrs%' then 'women'
													   when TitleOfCourtesy like 'Mr%' then 'men' 
													   else 'men' end as gender
	from Employees) as subquery
group by gender


-- �������� ������������ ��������� � �� ����. ����� � ������� ��������� CASE �������� ������� � ������������ �� ����. 
-- ���� ���� �� 0 �� 9.99,  �� ��� ������� '0-9.99'. ���� ���� �� 10 �� 29.99, �� ��� ������� '10-29.99'. 
-- ���� ���� �� 30 �� 49.99, �� ��� ������� '30-49.99'. ���� ���� �� 50, �� ��� ������� '50+'. 
-- ����� � ������� ���������� ������� ���������� ���-�� ������� � ������� ������� ��������. ������� ������� � �������� '50+'?
select price_segment, COUNT(*)
from
	(select ProductName, UnitPrice, case when UnitPrice < 9.99 then '0-9.99'
										when UnitPrice < 30.00 then '10-29.99'
										when UnitPrice < 50.00 then '30-49.99'
										else '50+' end as price_segment
	from Products) as subquery
where price_segment = '50+'
group by price_segment


-- �������������� ������ �������
select UnitPrice, --����
        SQRT(UnitPrice), --������� ������ �� �����
        SQUARE(UnitPrice) --�������� ����� � �������
from Products

-- ���������� ����� ������� �� ���� �������, ������� ���� ��������� � 1996 ����. 
-- C ������� ������� Round() ��������� ����� �� ������ �����.

select round(sum(t1.UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details] as t1
inner join Orders as t2
on t1.OrderID = t2.OrderID
where OrderDate between '1996-01-01 00:00:00.000' and '1996-12-31 00:00:00.000'

--������� �� ������ � ������ � ��������
select 
DAY(OrderDate),
MONTH(OrderDate),
YEAR(OrderDate)
from Orders

-- ���������� ������� ��������� ���� � ����� �� ������� ��������� �����
SELECT GETDATE() + 0.125 -- �.�. + 3 ����, �.�. ������ ��������� � �������. ���� ���������
-- 1, �� ����������� 1 ����, ������� 0.125 ��� 3 ����, 1/24*3 = 0.125

-- ���������� ��������� ���� (���, �������, �����, ������) � ����� �����
SELECT 
DATEPART(year, GETDATE() + 0.125),
DATEPART(quarter, GETDATE() + 0.125),
DATEPART(month, GETDATE() + 0.125),
DATEPART(week, GETDATE() + 0.125),
DATEPART(day, GETDATE() + 0.125),
DATEPART(hour, GETDATE() + 0.125),
DATEPART(minute, GETDATE() + 0.125)

-- ���������� ����, ������� �������� ����������� �������� ����� � ���������� ����
select
DATEADD(year, 3, GETDATE() + 0.125),
DATEADD(month, 2, GETDATE() + 0.125),
DATEADD(day, -4, GETDATE() + 0.125)


-- ���������� ������� ����� ����� ������
SELECT
DATEDIFF(year, GETDATE() + 0.125, '2020-11-20'),
DATEDIFF(month, GETDATE() + 0.125, '2020-11-20'),
DATEDIFF(day, GETDATE() + 0.125, '2020-11-20')

-- ��������� ����� ����������� ������� �� �������
SELECT 
year(OrderDate),
MONTH(OrderDate),
count(OrderID)
FROM Orders
group by year(OrderDate), month(OrderDate)
order by year(OrderDate), month(OrderDate)

-- �������� ������ ������, ������� ���� ���������� ������� � ������� 31 ��� � ������� ������
select
OrderID,
OrderDate,
ShippedDate,
DATEADD(day, 31, OrderDate) as date2,
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where ShippedDate between OrderDate and DATEADD(day , 31, OrderDate) -- ������ ��� ������������� ������� DATEADD


-- ���� �����
select
OrderID,
OrderDate,
ShippedDate,
DATEADD(day, 31, OrderDate) as date2,
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where DATEDIFF(day, OrderDate, ShippedDate) <= 31

-- �������������� ���������� �� ������������� � ������ �������� ��� ������ � 
-- ������ � �������� � �� ������ ����� � ���� ��������  https://metanit.com/sql/sqlserver/8.3.php  
-- ��� �� https://learn.microsoft.com/ru-ru/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15
-- � ����������� �������������.

-- ���������� ����� ���������� ������� ���� ������� � 1997 ���� �� ���������. ������� ������� ���� ������� � ��������� ��������?
select COUNT(*)
--DATEPART(quarter, OrderDate) as quarter_table
from Orders
where YEAR(OrderDate) = 1997 and DATEPART(quarter, OrderDate) = 4
group by DATEPART(quarter, OrderDate) 

-- ����� ������������ ���������� ���� ������ � ������� ������ (OrderDate) �� ������� �������� (ShippedDate) ����� ���� �������? 
-- ���� ���� �������� �� �������, �� ����� �� ���������. 
select top 1
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where ShippedDate is not null
order by DATEDIFF(day, OrderDate, ShippedDate) desc


-- LOWER() � UPPER() �������� ������� � ������� � ������ ��������
select
LOWER(CompanyName),
UPPER(CompanyName)
from Customers

-- LEFT() � RIGHT() �������� ����������� ����������� �������� ����� � ������ ��������������
select
UnitPrice,
LEFT(UnitPrice, 2),
RIGHT(UnitPrice, 2)
from Products

-- ������� LEN() ������� ����������� �������� � ������ 
select len(ContactName)
from Customers

--  ������� CONCAT() ���������� ��������� ����� � ����
select FirstName, LastName, CONCAT(FirstName, ' ', LastName) as ContactName
from Employees

-- ������� REPLACE() �������� ����� ������
select ContactTitle, REPLACE(ContactTitle, 'Owner', 'Business owner')
from Customers

-- ������� SUBSTRING() ���������� ����� ������ �� ������
select ContactTitle, SUBSTRING(ContactTitle, 12, 7) -- 12 ��� ������ ������� � �������� ���� ������ ����������, � 7 ��� ����������� 
from Customers                                      -- �������� ������� ���� �������
where ContactTitle = 'Accounting Manager'

select ContactTitle, RIGHT(ContactTitle, 8)
from Customers                                     
where ContactTitle = 'Accounting Manager'

select ContactTitle, RIGHT(ContactTitle, CHARINDEX('ing', ContactTitle)-1)
from Customers                                     
where ContactTitle = 'Accounting Manager'

select ContactTitle, LEFT(ContactTitle, CHARINDEX(' ', ContactTitle)) -- �������� ������ ����������� �������, � ����� ���� ������ �� ����������� �������
from Customers                                     
where ContactTitle = 'Accounting Manager'

-- ����� ���������� �������� ����� �������� ������� ����� ��� �� 10 ��������?
select distinct Country
from Customers
where len(Country) > 10


-- �������� �������, ��� ��������� ������� ��� Owner/Marketing Assistant. 
-- � ����� ���������� ���������� ������� SUBSTRING() �������� �� ��������� ������ Marketing Assistant?
SELECT ContactName, SUBSTRING(ContactTitle, 7, LEN(ContactTitle))
FROM Customers
WHERE ContactTitle = 'Owner/Marketing Assistant';

SELECT ContactName, SUBSTRING(ContactTitle, CHARINDEX('Mar', ContactTitle), LEN(ContactTitle))
FROM Customers
WHERE ContactTitle = 'Owner/Marketing Assistant';

SELECT ContactName, SUBSTRING(ContactTitle, 7, 19), len(ContactTitle)
FROM Customers
WHERE ContactTitle = 'Owner/Marketing Assistant';

SELECT SUBSTRING(ContactTitle, LEN('Owner/*'), LEN('Marketing Assistant'))
FROM Customers
WHERE ContactTitle LIKE 'Owner/Marketing Assistant'

