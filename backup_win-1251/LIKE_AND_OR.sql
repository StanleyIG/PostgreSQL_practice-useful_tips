-- Фильтрация строк WHERE. Регулярные выражения LIKE. AND и OR

-- фильтрация строк
-- шаблонные выражения 
-- оператор like

select ContactName, ContactTitle
from Customers
where ContactTitle = 'Sales Manager';

select ContactName, ContactTitle
from Customers
where ContactTitle LIKE 'Sales%';

-- 'Sales%' знак % после шаблонного значения означает, что может быть сколько
-- угодно знаков после %

-- вывести клиентов чьи имена начинаются на A
select ContactName, ContactTitle
from Customers
where ContactName LIKE 'A%';


-- знак % до шаблонного значения означает, что может быть сколько
-- угодно знаков до %
select ContactName, ContactTitle
from Customers
where ContactTitle LIKE '%Manager';


-- если значение поля обособлено в знак %, то будут выведены все 
-- значения где есть значение Sales, не важно в начале, в середине или в конце.
select ContactName, ContactTitle
from Customers
where ContactTitle LIKE '%Sales%';


-- ссылка на ресурс по регулярным выражениям https://metanit.com/sql/sqlserver/4.6.php

-- Выведите города, начинающиеся на букву "W", в которых проживают клиенты. Какие города вывел запрос?
select City
from Customers
where City LIKE 'W%'

-- Выведите клиентов, чей номер телефона (Phone) содержит "5555". 
-- Сколько их? Четыре символа (пятерки) подряд могут быть в начале номера, в середине или в конце.

select COUNT(*) as count_client
from Customers
where Phone LIKE '%5555%'

-- Фильтрация строк, оператор OR

-- вывести клиентов которые проживают в стране франция или в городе London
select ContactName, City, Country
from Customers
where Country = 'France'
or
City = 'London'


-- and

-- вывести всех клиентов из 'France' и городов которые начинаются на букву L
select ContactName, City, Country
from Customers
where Country = 'France'
and
City like 'L%'

-- вывести товары стоимостью больше 10, но меньше 15
select ProductName, UnitPrice
from Products
where UnitPrice > 10 and UnitPrice < 15;


-- between

-- between даёт возможность указать диапазон от 10 до 15
select ProductName, UnitPrice
from Products
where UnitPrice between 10 and 15;

select OrderID, OrderDate 
from Orders
where OrderDate between '1997-07-09 00:00:00.000' and '1997-07-12 00:00:00.000'


-- приоритет and или or
-- в приоритете всегда будет оператор and котоый объеденит по условиям поля ProductID, UnitPrice
-- а затем выполнится оператор or в итоге выведутся значения для обоих условий
select ProductID, UnitPrice
from Products
where ProductID = 1 or ProductID = 2 and UnitPrice = 19

-- но если объеденить ProductID = 1 or ProductID = 2 в скопки, то в приоритете
-- будет оператор or
-- выберется ProductID который будет сопостовим UnitPrice через оператор and
select ProductID, UnitPrice
from Products
where (ProductID = 1 or ProductID = 2) and UnitPrice = 19

-- Выведите информацию о клиенте, который проживает в стране США и работает в 
-- должности "Marketing Assistant". Как зовут этого человека?
select ContactName
from Customers
where Country = 'USA' and ContactTitle = 'Marketing Assistant'

-- Выведите продукты, которые стоят больше 100 долларов или называются Chai. 
-- Столбцы для вывода: название продукта и цена продукта. Сколько продуктов вывел запрос?

-- выводит доп.столбец с общим колличеством
SELECT
    ProductName,
    UnitPrice,
    (SELECT COUNT(*)
     FROM Products
     WHERE UnitPrice > 100 OR ProductName = 'Chai') as total
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'

-- по отдельности для каждого
SELECT UnitPrice, ProductName, COUNT(*) as item_prod
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'
GROUP BY ProductName, UnitPrice


-- просто запрос
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai'


-- с использованием оконных функций COUNT OVER (PARTITION BY) PARTITION BY разделяет рез по группам
-- по уник. знач. в столбцах
SELECT
    ProductName,
    UnitPrice,
    COUNT(*) OVER (PARTITION BY ProductName, UnitPrice) as item,
    COUNT(*) OVER () as total
FROM Products
WHERE UnitPrice > 100 OR ProductName = 'Chai';


-- выводит то-же что и выше, но с помощью сравнения p1 и p2, 
-- т.к. в столбец item не запихнуть набор из ProductName и UnitPrice
-- иначе бы каждой ячейке item пришлось бы вмещать в себя по нескольку значений, что невозможно
SELECT
    ProductName,
    UnitPrice,
    (SELECT COUNT(*)
		FROM Products
		WHERE UnitPrice > 100 OR ProductName = 'Chai') as total_number_products,
	(SELECT COUNT(*)
		FROM Products AS p2
		WHERE (p2.UnitPrice > 100 OR p2.ProductName = 'Chai') 
		AND p2.ProductName = p1.ProductName 
		AND p2.UnitPrice = p1.UnitPrice) as item
FROM Products AS p1
WHERE UnitPrice > 100 OR ProductName = 'Chai';




