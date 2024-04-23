--  Группировка строк GROUP BY и HAVING. Создание отчетов

select Country, COUNT(*) as cnt_country
from Customers
where Country <> 'Germany'
group by Country
having COUNT(*) > 10


-- дать колличество должностей в германии колличество которых больше 2-х
-- должность Sales Representative
select ContactTitle, COUNT(*) as cnt_title
from Customers
where Country = 'Germany'
group by ContactTitle
having COUNT(*) > 2 -- фильтр having всегда идёт после group by


-- Вывести мин. макс., сред, суммк товаров по каждой категории, т.е. сгруппировать категории.
-- Отфильтровать по колличеству товаров больше 10 и ценой больше 5
select CategoryID, COUNT(*) as cnt_product, 
min(UnitPrice) as min_price, 
max(UnitPrice) as max_price, 
AVG(UnitPrice) as avg_price, 
SUM(UnitPrice) as  sum_price
from Products
group by CategoryID
having COUNT(*) > 10 and min(UnitPrice) > 5


-- сгруппировать клиентов по странам,
-- показать колличество клиентов в каждой стране,
-- отфильтровать по колличеству клиентов на страну более 5,
-- отсортировать в порядке возростания
select Country, count(*)
from Customers
group by Country
having count(*)>5
order by count(*) 


-- сортировка в алфавитном порядке по убыванию(в обратном порядке)
select Country, count(*)
from Customers
group by Country
having count(*)>5
order by Country desc

-- Выведите список городов и кол-во проживающих в них клиентов. Оставьте города, в которых проживает больше 4 клиентов. Какие это города?
-- Используйте GROUP BY и HAVING.

select City, COUNT(*) as cnt_client
from Customers
group by City
having COUNT(*) > 4

-- Из таблицы Products выведите ID категорий (СategoryID) и среднюю стоимость товаров в категориях. 
-- В какой категории (CategoryID) самая высокая средняя стоимость товаров?


SELECT CategoryID, AVG(UnitPrice) AS avg_price
FROM Products
GROUP BY CategoryID
ORDER BY avg_price DESC

SELECT top 1 CategoryID, AVG(UnitPrice) AS avg_price, COUNT(*) AS cnt_products
FROM Products
GROUP BY CategoryID
ORDER BY avg_price DESC

-- Выведите даты заказов (OrderDate) и кол-во заказов, совершенных в марте 1998 года. 
-- Оставьте даты, в которые было совершено 4 заказа. Сколько их?
-- Примените WHERE и HAVING.

select OrderDate, COUNT(*) as cnt_orders
from Orders
where OrderDate between '1998-03-01 00:00:00.000' and '1998-03-31 00:00:00.000'
group by OrderDate
having COUNT(*) = 4

-- выводит колличество строк результирующего запроса
SELECT COUNT(*) as cnt_product
FROM (
    SELECT COUNT(*) as cnt_orders
    FROM Orders
    WHERE OrderDate BETWEEN '1998-03-01 00:00:00.000' AND '1998-03-31 00:00:00.000'
    GROUP BY OrderDate
	having COUNT(*) = 4
) AS subquery;

-- тоже самое но с использованием функции MONTH для получения 
-- конкретного месяца и YEAR для получения конкретного года
SELECT COUNT(*)
FROM (
    SELECT OrderDate
    FROM Orders
    WHERE MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 1998
    GROUP BY OrderDate
    HAVING COUNT(*) = 4
) AS SubQuery;


-- посмотреть колличество профессий в разрезе стран и должностей в колличестве более 2-ух
select Country, ContactTitle, COUNT(*) as cnt_customers
from Customers
group by Country, ContactTitle
having COUNT(*) > 1
order by Country, ContactTitle

-- стоимость для определённого заказа
select UnitPrice * Quantity * (1-Discount)
from [Order Details]
where OrderID = 10250


-- общая стоимость для определённого заказа
select sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
where OrderID = 10250

-- общая стоимость для каждого заказа
select OrderID, sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
group by OrderID

-- Выберите формулу, которая рассчитает в таблице Order Details выручку по конкретному 
-- продукту в чеке (выручку по одной строке) с учетом количества штук (quantity) и размера скидки.

-- показать общую сумму товаров с ProductID = 11 в каждом заказе
select OrderID, sum(UnitPrice * Quantity * (1-Discount))
from [Order Details]
where ProductID = 11
group by OrderID


-- Из таблицы Order Details выведите уникальные номера заказов (OrderID) и стоимость (выручку) заказов. 
-- Учитывайте кол-во штук товара и размер скидки. Сколько заказов стоит больше 10 000?
select COUNT(*) cnt_result
from
	(select OrderID, sum(UnitPrice * Quantity * (1-Discount)) as total -- В подзапросе необходимо явно указывать алиас
	from [Order Details]                                               -- для столбца, который представляет собой результат агрегированной функции.
	group by OrderID
	having sum(UnitPrice * Quantity * (1-Discount)) > 10000)
	as result; -- так-же необходимо указать alias и для самого подзапроса