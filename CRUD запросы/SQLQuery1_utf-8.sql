

-- показать всё из таблицы Products
--select *
--from Products


-- Таким образом, запрос извлекает информацию о прекращенных 
-- продуктах с ценой 14, включая название категории, название 
-- продукта, цену продукта и город поставщика.
SELECT c.CategoryName, p.ProductName, p.UnitPrice, s.City
FROM Products AS p
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
JOIN Categories AS c ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 1
and p.UnitPrice = 14


-- если значение nul
select * 
from
Customers
where Region is null

-- если значение не null
select * 
from
Customers
where Region is not null

-- выведет всё кроме указанных значений в поле
 select * from Products where ProductName not in ('Tofu','Konbu','Chang')

-- выведет только строки с указанными значениями в поле ProductName 
 select * from Products where ProductName in ('Tofu','Konbu','Chang')


 -- Этот SQL-запрос извлекает все строки из таблицы Products, где значение 
 -- в столбце ProductName меньше (в алфавитном порядке) чем строка 'Ikura'. 
 -- Здесь сравнение производится в лексикографическом порядке (по алфавиту).
 select *
from Products
where ProductName < 'Ikura'

-- колличество товаров стоимостью больше 100
select COUNT(*)
from Products
where UnitPrice > 100

-- вывести клиентов из испании
-- Общее количество строк

SELECT
    Country,
    CompanyName,
    ContactName,
    (SELECT COUNT(*) FROM Customers WHERE Country = 'Spain') AS total_umbe
FROM Customers
where Country = 'Spain'

select COUNT(*) as spain_count
FROM Customers
where Country = 'Spain'









