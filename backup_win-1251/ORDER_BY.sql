-- ���������� ����� ORDER BY

-- �������� ������, ��������� � ���� (Orderdate) 1998-02-26 00:00:00.000. ������������ ������ �� ���� (Freight). 
-- ����� ����� ������ (Order ID) ����� ����� ������� ���?
select OrderID, Freight 
from Orders
where OrderDate = '1998-02-26 00:00:00.000'
order by Freight

-- �������� ������, ��������� � ���� (Orderdate) 1998-02-26 00:00:00.000. 
-- ������������ ������ �� ���� ��������: ID ���������� �������� (EmployeeID), ��� ������ (Freight). 
-- ������� ����������� ��� ������, ����������� ����������� � ID ������ ������� � ��������� ����.
select EmployeeID, Freight 
from Orders
where OrderDate = '1998-02-26 00:00:00.000' 
order by EmployeeID, Freight