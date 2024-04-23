-- LEFT JOIN и остальные виды JOIN-ов
-- показать клиентов и колл-во заказов в порядке возрастания
select ContactName, COUNT(distinct t2.OrderID)
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
group by ContactName
order by COUNT(OrderID)

-- показать колличество уникальных клиентиов у которых не бюыло заказов
select COUNT(distinct t1.CustomerID)
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
where OrderID is null


-- В каких городах проживают клиенты, которые не совершили ни одного заказа? 
-- Используйте LEFT JOIN для решения задачи. Похожая задача была в видео-уроке. 

select t1.City
from Customers as t1
left join Orders as t2
on t1.CustomerID = t2.CustomerID
where OrderID is null

-- Синтаксис при RIGHT JOIN и FULL JOIN такой же как при INNER JOIN или LEFT JOIN. 
-- А при CROSS JOIN нет необходимости указывать связь по ключу. 
-- Выполните данный запрос: select * from Categories cross join Products

select * from Categories cross join Products


-- Объединение нескольких таблиц с помощью UNION и UNION ALL

-- вывести список уникальных должностей из таблиц клиентов и сотрудников
select Title
from Employees
union
select ContactTitle
from Customers

-- вывести должности которые присутсвуют в первой таблице, но отсуствуют во второй
select Title
from Employees
except 
select ContactTitle
from Customers

-- вывести должности которые присутсвуют и в первой и во второй таблице
select Title
from Employees
intersect
select ContactTitle
from Customers


-- При помощи оператора UNION можно объединить списки, которые состоят из любого количества столбцов. 
-- Выполните SQL-запросы ниже и сравните количество полученных строк.

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

-- Объедините список городов сотрудников и список городов клиентов в один список. 
-- Сколько уникальных городов получилось в результате?

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


-- Подзапросы
-- вывести колличество дней с коллличеством заказов больше 2-ух
select COUNT(*)
from
	(select OrderDate, COUNT(*) as cnt
	from Orders
	group by OrderDate
	having count(*) > 2) as total1

-- пример №2

select CustomerID
from Customers
where Country = 'USA'

select *
from Orders
where CustomerID in ('VINET', 'TOMSP', 'HANAR')

-- вывести список закасов у которых клиента проживают в USA
select *
from Orders
where CustomerID in (select CustomerID
					from Customers
					where Country = 'USA')


-- вывести долю выручки по каждой стране в порядке убывания

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

-- вывести страну с самой большой долей вырочки
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


-- В этой статье дополнительные примеры вложенных запросов. Также про вложенные запросы можно прочесть на официальной странице.
-- https://info-comp.ru/obucheniest/747-subqueries-in-t-sql.html

-- https://learn.microsoft.com/ru-ru/sql/relational-databases/performance/subqueries?view=sql-server-ver15

-- Выведите страны и кол-во клиентов, которые проживают в этих странах. 
-- Оставьте только страны с количеством клиентов более одного. Затем с помощью вложенного запроса посчитайте количество таких стран.

-- ВАЖНО: задайте Alias-ы для вложенного запроса и столбца, который является результатом 
-- применения агрегирующей функции, иначе вложенный запрос не сработает.
select COUNT(*) cnt_country
from
	(select Country, COUNT(*) cnt_customers
	from Customers
	group by Country
	having COUNT(*) > 1) as subqary


-- Выведите ID клиентов и кол-во заказов, которые совершили клиенты. 
-- Оставьте только ID клиентов с количеством заказов более 10. Затем с помощью вложенного запроса посчитайте количество таких клиентов.

-- ВАЖНО: задайте Alias-ы для вложенного запроса и столбца, который является результатом
-- применения агрегирующей функции, иначе вложенный запрос не сработает.

select COUNT(*) as cnt_customers
from
	(select CustomerID, COUNT(*) as cnt_orders
	from Orders
	group by CustomerID
	having COUNT(*) > 10) as subquary


-- Выведите товары, которые относятся к CategoryID =1. Используйте этот SQL-запрос как подзапрос для того, чтобы посчитать 
-- общую выручку по товарам, которые относятся к CategoryID = 1. Ответ округлите до целого числа.

-- Примечание:  Задачу решайте по примеру №2 из обучающего видео.
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





-- Практика по итогам 2-го модуля
-- Посчитайте количество заказов, в которых присутствует товар Chocolade.

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

-- Посчитайте общую выручку, которую принесли товары категории Confections. Ответ округлите до целого числа.
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

-- Посчитайте выручку по каждой категории. Какая категория принесла самую высокую выручку?
select top 1 CategoryName, round(sum(t2.UnitPrice * t2.Quantity * (1 - t2.Discount)), 0) as total
from Products as t1
inner join [Order Details] as t2
on t1.ProductID = t2.ProductID
inner join Categories as t3
on t1.CategoryID = t3.CategoryID
group by CategoryName
order by total desc


-- Клиент Simon Crowther утверждает, что оформил заказ 29 апреля 1998 года, но заказ пришел неполный - часть товаров отсутствует. 
-- Найдите всю информацию по сотруднику, который оформил этот заказ, чтобы связаться с ним. Как зовут этого сотрудника?

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


-- Выведите города доставки (Shipcity) и кол-во заказов, которые были оформлены в эти города в 1997 году. 
-- Оставьте только города с количеством заказов больше 5. 
-- Затем с помощью вложенного запроса посчитайте количество найденных городов.

select COUNT(*)
from
	(select ShipCity, COUNT(*) as cnt_orders
	from Orders
	where OrderDate between '1997-01-01 00:00:00.000' and '1997-12-31 00:00:00.000'
	group by ShipCity
	having COUNT(*) > 5) as subquary
