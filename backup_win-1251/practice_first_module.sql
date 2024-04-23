-- � ������ ���������� �������� � ��������� ���� ����� Sales, � ������ �� ��������?

select COUNT(*)
from Customers
where ContactTitle like '%Sales%' and Region is null

-- ������� ����� ���������� ��������� ����� ��������.
select top 2 ContactTitle, COUNT(*) as cnt_cont_title
from Customers
group by ContactTitle
order by cnt_cont_title desc

-- �������� ������������ � ����������� ��������� ������� � ������ ��������� (CategoryID). 
-- � ����� ��������� ����� ������� ������� ����� ����� ������� ����� ������ � ����� ������ �����?
select top 1 CategoryID, 
		max(UnitPrice) max_price, 
		min(UnitPrice) min_price,
		max(UnitPrice) - min(UnitPrice) as diff_price
from Products
group by CategoryID
order by diff_price desc

-- ������� 2
select top 1 CategoryID, 
		max(UnitPrice) max_price, 
		min(UnitPrice) min_price
from Products
group by CategoryID
order by max(UnitPrice) - min(UnitPrice) desc

-- ������� ����� (OrderID) � ����� ������� ����������� ���� (Quantity) ������� � ����. 
-- ���� � ������ ��������� ������ �������, �� ����� ����� �������. ����� OrderID � ������?
select top 1 OrderID, SUM(Quantity) as total_quantity
from [Order Details]
group by OrderID
order by total_quantity desc

-- ������ 2
select top 1 OrderID
from [Order Details]
group by OrderID
order by SUM(Quantity) desc


-- ���������� ��������� ������ ����������� ������ �� ������� ������ (�� � ���������/�� � �����). 
-- � �������� ������� ������ ��������� ������ 3 000?
-- ����������: � ������� Discount ������� ������ � �����. ��������� ��� ���c������ ����������� ������.
select OrderID, sum(UnitPrice * Quantity * (Discount)) as sum_discont
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (Discount)) > 3000
order by sum_discont desc

-- ������� 2
select OrderID
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (Discount)) > 3000
order by sum(UnitPrice * Quantity * (Discount)) desc

--������� 3
SELECT 
	OrderID, 
	SUM(UnitPrice * Quantity * (Discount)) AS total_discont,
	SUM(UnitPrice * Quantity) -  SUM(UnitPrice * Quantity * (Discount)) as total_price
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity * (1 - Discount)) > 3
ORDER BY total_discont DESC;
