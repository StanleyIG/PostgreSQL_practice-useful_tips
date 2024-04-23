-- Какой грузоотправитель исполнил больше всего заказов?
select top 1 ShipName, COUNT(*) as cnt_orders
from Orders
group by ShipName
order by cnt_orders desc

select *
from Shippers
where CompanyName = 'Speedy Express'

select top 1 t2.CompanyName, COUNT(*) as cnt_orders
from Orders as t1
inner join Shippers as t2
on t1.ShipVia = t2.ShipperID
group by t2.CompanyName
order by cnt_orders desc

-- Как зовут клиента с наибольшим кол-вом заказов?
select top 1 ContactName, COUNT(*) as cnt_orderrs
from Customers as t1
inner join Orders as t2
on t1.CustomerID = t2.CustomerID
group by t1.ContactName
order by cnt_orderrs desc

-- Посчитайте количество клиентов, у которых Французский язык является официальным. 
-- Это жители страны Франции или города Женевы, который находится в Швейцарии.

select COUNT(*)
from Customers
where Country = 'France' or City = 'Genève'

-- Найдите клиента, который проживает в одном городе (City), но оформляет доставку в другой город (Shipcity).
select ContactName
from Orders as t1
inner join Customers as t2
on t1.CustomerID = t2.CustomerID
where t1.ShipCity != t2.City

-- Сначала выведите имена всех жителей Испании. Затем добавьте по каждому жителю 
-- количество совершенных заказов. Сколько заказов совершил Diego Roel? 

-- Примечание: задачу можно решить с помощью LEFT JOIN.

SELECT ContactName, 
       SUM(CASE WHEN OrderID IS NOT NULL THEN 1 ELSE 0 END) AS cnt_orders
FROM Customers AS t1
LEFT JOIN Orders AS t2 ON t1.CustomerID = t2.CustomerID
WHERE Country = 'Spain'-- AND ContactName = 'Diego Roel'
GROUP BY ContactName;

-- Посчитайте количество заказов, которые не были доставлены (столбец ShippedDate не заполнен)?
select COUNT(*)
	from 
	(select OrderID
	from Orders
	where ShippedDate is null
	group by OrderID) as subquary

select COUNT(*)
	from Orders
	where ShippedDate is null

select COUNT(*)
from Orders
where ShippedDate is null
group by ShippedDate


-- В какие города (ShipCity) страны (ShipCountry) Великобритания были оформлены заказы в феврале 1998 года?
select ShipCity
from Orders
where ShipCountry = 'UK' 
and OrderDate between '1998-02-01 00:00:00.000' and '1998-02-28 00:00:00.000'

select ShipCity
from Orders
where ShipCountry = 'UK' 
and YEAR(OrderDate) = 1998 and MONTH(OrderDate) = 2

-- C помощью LIKE найдите клиентов с именами, которые начинаются на Mari. Сколько их?
select COUNT(*)
from
	(select COUNT(*) as cnt_name
	from Customers
	where ContactName like 'Mari%'
	group by ContactName) as subquery

Select count(*)
From Customers
Where ContactName Like 'Mari%'


-- C помощью функции LEN() найдите самое длинное полное имя (имя и фамилия) клиента. 
-- Из какого количества символов, включая пробел, состоит полное имя.
select top 1 len(ContactName) as len_name
from Customers
order by len_name desc

-- Найдите заказ (OrderID), стоимость которого составила 2900.
select orderid
from [Order Details]
group by OrderID
having sum(UnitPrice*Quantity*(1-Discount)) = 2900

-- СЛОЖНЫЕ ЗАПРОСЫ

-- Посчитайте выручку по каждой неделе 1998-го года. Какова максимальная недельная выручка? Ответ округлите до целого числа.

select top 1 round(sum(UnitPrice*Quantity*(1-Discount)), 0) as week_revenue
from [Order Details] as t1
inner join Orders as t2
on t1.OrderID = t2.OrderID
where year(OrderDate) = 1998
group by DATEPART(week, OrderDate)
order by week_revenue desc


-- Посчитайте по месяцам количество заказов, которые совершили клиенты из США. Сколько заказов было сделано в декабре 1996 года?
select COUNT(*)
from Orders
where ShipCountry = 'USA' and (YEAR(OrderDate) = 1996 and MONTH(OrderDate) = 12)
group by DATEPART(Month, OrderDate)

-- Какое максимальное количество заказов в месяц было оформлено одним сотрудником?

SELECT EmployeeID, MONTH(OrderDate), COUNT(*) as cnt
FROM Orders
GROUP BY EmployeeID, MONTH(OrderDate)
ORDER BY cnt desc


-- правильный вариант
SELECT EmployeeID, 
       YEAR(OrderDate) as OrderYear, 
       MONTH(OrderDate) as OrderMonth, 
       COUNT(OrderID) as TotalOrders
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)
ORDER BY TotalOrders DESC

-- В обоих запросах используется агрегация данных по сотрудникам и месяцам, чтобы подсчитать количество заказов. 
-- Однако есть различия в том, как производится агрегация.
-- В первом запросе, вы используете функцию MONTH() для вычисления месяца из OrderDate, но не учитываете год. 
-- Это значит, что для каждого сотрудника будет подсчитано количество заказов для каждого месяца всех лет. 
-- То есть один месяц может быть учтен несколько раз, если сотрудник сделал заказы в этом месяце в разные годы.
-- Во втором запросе, вы агрегируете данные по годам (YEAR(OrderDate)) и месяцам (MONTH(OrderDate)), что позволяет 
-- точнее подсчитать количество заказов для каждого сотрудника в отдельном месяце каждого года.
-- Простыми словами, в первом запросе могут быть дубликаты месяцев из разных лет, в то время как во втором 
-- запросе каждый месяц учитывается только один раз в рамках каждого года.







