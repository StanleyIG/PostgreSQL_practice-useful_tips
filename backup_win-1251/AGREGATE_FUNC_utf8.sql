-- Агрегирующие функции: COUNT, SUM, MIN, MAX, AVG. Алиасы

-- COUNT

select *
from Customers
where Country = 'USA'

select COUNT(*), COUNT(ContactTitle), COUNT(City), COUNT(Country)
FROM Customers;

select COUNT(Country)
from Customers
-- 91

-- distinct 
-- distinct выводит уникальные значения для столбцов
select distinct Country
from Customers

select COUNT(distinct Country)
from Customers
-- 21

-- 91             -- 12                        -- 69                  -- 21
select COUNT(*), COUNT(distinct ContactTitle), COUNT(distinct City), COUNT(distinct Country)
FROM Customers;


-- агрегирующие функции 
-- sum()
-- min()
-- max()
-- avg()

-- пример №1 и алиасы
select sum(Unitprice), min(UnitPrice), max(UnitPrice), avg(UnitPrice), count(UnitPrice)
from Products

-- пример №2
select min(Freight),max(Freight), AVG(Freight), sum(Freight)
from Orders
where OrderDate between '1997-01-01 00:00:00.000' and '1997-01-31 00:00:00.000'


-- min max с датами
select min(OrderDate), max(OrderDate)
from Orders

-- Выведите минимальную, среднюю и максимальную стоимость продуктов, которые входят в категорию (CategoryID) №3. 
-- Какова максимальная стоимость продуктов в этой категории? Ответ округлите до целого числа. 
-- Присвойте итоговым столбцам новые имена: min_price, avg_price, max_price.

select min(UnitPrice) as min_price, avg(UnitPrice) as avg_price, max(UnitPrice) as max_price 
from Products
where CategoryID = 3


-- Посчитайте кол-во уникальных профессий клиентов, проживающих в Великобритании.
select count(distinct ContactTitle)
from Customers
where country = 'UK'

-- Посчитайте суммарную стоимость всех продуктов из категорий №4 и №5.
select sum(UnitPrice)
from Products
where CategoryID = 4 or CategoryID = 5 --CategoryID between 4 and 5

select sum(UnitPrice)
from Products
where CategoryID between 4 and 5

select sum(UnitPrice)
from Products
where CategoryID in (4, 5)

select CategoryID,
(select
sum(UnitPrice) 
from Products
where CategoryID between 4 and 5) as total
from Products
where CategoryID between 4 and 5
