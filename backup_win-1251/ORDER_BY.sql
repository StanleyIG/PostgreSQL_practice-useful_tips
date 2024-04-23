-- Сортировка строк ORDER BY

-- Выведите заказы, сделанные в дату (Orderdate) 1998-02-26 00:00:00.000. Отсортируйте заказы по весу (Freight). 
-- Какой номер заказа (Order ID) имеет самый большой вес?
select OrderID, Freight 
from Orders
where OrderDate = '1998-02-26 00:00:00.000'
order by Freight

-- Выведите заказы, сделанные в дату (Orderdate) 1998-02-26 00:00:00.000. 
-- Отсортируйте заказы по двум столбцам: ID сотрудника компании (EmployeeID), вес заказа (Freight). 
-- Укажите минимальный вес заказа, оформленный сотрудником с ID равным единице в указанную дату.
select EmployeeID, Freight 
from Orders
where OrderDate = '1998-02-26 00:00:00.000' 
order by EmployeeID, Freight