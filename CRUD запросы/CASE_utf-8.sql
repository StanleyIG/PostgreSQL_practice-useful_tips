-- Выражение CASE
use Northwind;

select ContactName, City, Region, case when Region is null then 'not defiened' else Region end as new_column
from Customers

-- создать колонку континентов по странам
select ContactName, Country, case when country in ('Argentina', 'Brazil') then 'South America'
                                  when country in ('Argentina', 'Brazil') then 'North America'
								  when country in ('Spain', 'Portugal') then 'Europe' end as Continent
from Customers
where Country in ('Argentina', 'Brazil', 'Argentina', 'Brazil', 'Spain', 'Portugal')


-- колличество клиентов в разрезе каждого континента
select continent, COUNT(ContactName)
from
	(
	select ContactName, Country, case when country in ('Argentina', 'Brazil') then 'South America'
									  when country in ('Argentina', 'Brazil') then 'North America'
									  else 'Europe' end as continent
	from Customers
	where Country in ('Argentina', 'Brazil', 'Argentina', 'Brazil', 'Spain', 'Portugal')) as table1
group by continent


-- ниже оба запроса создают колонку revenue_group, в которой устанавливаются значения выручки по каждому заказу
-- о 0 до 999, от 1000 до 4999 и от 5000 и выше
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


-- Выведите имена сотрудников, страны и регионы. С помощью выражения CASE добавьте новый временный 
-- столбец Region и замените пустые значения NULL на значения 'not defined'. 
-- У скольких сотрудников регион равен 'not defined'?
select Region, COUNT(FirstName)
from
	(select FirstName, Country, case when Region is null then 'not defiened' else Region end as Region
	from Employees) as subquary
group by Region 


-- Выведите имена, фамилии сотрудников и обращения (TitleOfCourtesy). 
-- Далее с помощью выражения CASE добавьте временный столбец Gender. 
-- Если обращение Ms. или Mrs., то gender - 'women', а если обращение Mr. или Dr., то gender - 'men'. 
-- Затем с помощью вложенного запроса посчитайте кол-во мужчин и женщин. Сколько сотрудников женского пола?
select gender, COUNT(*)
from
	(select FirstName, LastName, TitleOfCourtesy, case when TitleOfCourtesy like 'Ms%' then 'women'
													   when TitleOfCourtesy like 'Mrs%' then 'women'
													   when TitleOfCourtesy like 'Mr%' then 'men' 
													   else 'men' end as gender
	from Employees) as subquery
group by gender


-- Выведите наименования продуктов и их цену. Далее с помощью выражения CASE добавьте столбец с сегментацией по цене. 
-- Если цена от 0 до 9.99,  то это сегмент '0-9.99'. Если цена от 10 до 29.99, то это сегмент '10-29.99'. 
-- Если цена от 30 до 49.99, то это сегмент '30-49.99'. Если цена от 50, то это сегмент '50+'. 
-- Затем с помощью вложенного запроса посчитайте кол-во товаров в разрезе каждого сегмента. Сколько товаров в сегменте '50+'?
select price_segment, COUNT(*)
from
	(select ProductName, UnitPrice, case when UnitPrice < 9.99 then '0-9.99'
										when UnitPrice < 30.00 then '10-29.99'
										when UnitPrice < 50.00 then '30-49.99'
										else '50+' end as price_segment
	from Products) as subquery
where price_segment = '50+'
group by price_segment


-- дополнительные нужные функции
select UnitPrice, --цена
        SQRT(UnitPrice), --выводит корень из числа
        SQUARE(UnitPrice) --возводит число в квадрат
from Products

-- Посчитайте общую выручку по всем заказам, которые были оформлены в 1996 году. 
-- C помощью функции Round() округлите ответ до целого числа.

select round(sum(t1.UnitPrice * Quantity * (1 - Discount)), 0)
from [Order Details] as t1
inner join Orders as t2
on t1.OrderID = t2.OrderID
where OrderDate between '1996-01-01 00:00:00.000' and '1996-12-31 00:00:00.000'

--функции по рпботе с датами и временем
select 
DAY(OrderDate),
MONTH(OrderDate),
YEAR(OrderDate)
from Orders

-- возвращает текущую локальную дату и время на оснеове системных часов
SELECT GETDATE() + 0.125 -- т.е. + 3 часа, т.к. сервер находится в Европпе. Если прибавить
-- 1, то прибавиться 1 день, поэтому 0.125 это 3 часа, 1/24*3 = 0.125

-- возвращает компонент даты (год, квартал, месяц, неделя) в ввиде числа
SELECT 
DATEPART(year, GETDATE() + 0.125),
DATEPART(quarter, GETDATE() + 0.125),
DATEPART(month, GETDATE() + 0.125),
DATEPART(week, GETDATE() + 0.125),
DATEPART(day, GETDATE() + 0.125),
DATEPART(hour, GETDATE() + 0.125),
DATEPART(minute, GETDATE() + 0.125)

-- возвращает дату, которая является результатом сложения сичла к компоненту даты
select
DATEADD(year, 3, GETDATE() + 0.125),
DATEADD(month, 2, GETDATE() + 0.125),
DATEADD(day, -4, GETDATE() + 0.125)


-- возвращает разницу между двумя датами
SELECT
DATEDIFF(year, GETDATE() + 0.125, '2020-11-20'),
DATEDIFF(month, GETDATE() + 0.125, '2020-11-20'),
DATEDIFF(day, GETDATE() + 0.125, '2020-11-20')

-- построить отчёт колличества покупок по месяцам
SELECT 
year(OrderDate),
MONTH(OrderDate),
count(OrderID)
FROM Orders
group by year(OrderDate), month(OrderDate)
order by year(OrderDate), month(OrderDate)

-- оставить только заказы, которые были доставлены клиенту в течении 31 дня с момента заказа
select
OrderID,
OrderDate,
ShippedDate,
DATEADD(day, 31, OrderDate) as date2,
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where ShippedDate between OrderDate and DATEADD(day , 31, OrderDate) -- фильтр при использовании функции DATEADD


-- тоже самое
select
OrderID,
OrderDate,
ShippedDate,
DATEADD(day, 31, OrderDate) as date2,
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where DATEDIFF(day, OrderDate, ShippedDate) <= 31

-- Дополнительную информацию по рассмотренным и прочим функциям для работы с 
-- датами и временем и вы можете найти в этой полезной  https://metanit.com/sql/sqlserver/8.3.php  
-- или на https://learn.microsoft.com/ru-ru/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15
-- с официальной документацией.

-- Посчитайте какое количество заказов было сделано в 1997 году по кварталам. Сколько заказов было сделано в четвертом квартале?
select COUNT(*)
--DATEPART(quarter, OrderDate) as quarter_table
from Orders
where YEAR(OrderDate) = 1997 and DATEPART(quarter, OrderDate) = 4
group by DATEPART(quarter, OrderDate) 

-- Какое максимальное количество дней прошло с момента заказа (OrderDate) до момента доставки (ShippedDate) среди всех заказов? 
-- Если дата доставки не указана, то заказ не доставлен. 
select top 1
DATEDIFF(day, OrderDate, ShippedDate)
from Orders
where ShippedDate is not null
order by DATEDIFF(day, OrderDate, ShippedDate) desc


-- LOWER() и UPPER() приводит столбцы в верхний и нижний регистры
select
LOWER(CompanyName),
UPPER(CompanyName)
from Customers

-- LEFT() и RIGHT() вырезают определённое колдичество символов слева и справа соответственно
select
UnitPrice,
LEFT(UnitPrice, 2),
RIGHT(UnitPrice, 2)
from Products

-- функция LEN() считает колличество символов в строке 
select len(ContactName)
from Customers

--  функция CONCAT() объединяет несколько строк в одну
select FirstName, LastName, CONCAT(FirstName, ' ', LastName) as ContactName
from Employees

-- Функция REPLACE() заменяет часть строки
select ContactTitle, REPLACE(ContactTitle, 'Owner', 'Business owner')
from Customers

-- Функция SUBSTRING() извелекает часть строки из строки
select ContactTitle, SUBSTRING(ContactTitle, 12, 7) -- 12 это индекс символа с которого надо начать извлечение, а 7 это колличество 
from Customers                                      -- символов которое надо извлечь
where ContactTitle = 'Accounting Manager'

select ContactTitle, RIGHT(ContactTitle, 8)
from Customers                                     
where ContactTitle = 'Accounting Manager'

select ContactTitle, RIGHT(ContactTitle, CHARINDEX('ing', ContactTitle)-1)
from Customers                                     
where ContactTitle = 'Accounting Manager'

select ContactTitle, LEFT(ContactTitle, CHARINDEX(' ', ContactTitle)) -- получеть индекс пробельного символа, а потом срез строки до пробельного символа
from Customers                                     
where ContactTitle = 'Accounting Manager'

-- Какое количество названий стран клиентов состоят более чем из 10 символов?
select distinct Country
from Customers
where len(Country) > 10


-- Выведите клиента, чья должность указана как Owner/Marketing Assistant. 
-- С каким сочетанием аргументов функция SUBSTRING() извлечёт из должности только Marketing Assistant?
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

