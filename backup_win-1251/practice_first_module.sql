-- У какого количества клиентов в должности есть слово Sales, а регион не заполнен?

select COUNT(*)
from Customers
where ContactTitle like '%Sales%' and Region is null

-- Найдите самую популярную профессию среди клиентов.
select top 2 ContactTitle, COUNT(*) as cnt_cont_title
from Customers
group by ContactTitle
order by cnt_cont_title desc

-- Выведите максимальную и минимальную стоимость товаров в каждой категории (CategoryID). 
-- В какой категории самая большая разница между самой высокой ценой товара и самой низкой ценой?
select top 1 CategoryID, 
		max(UnitPrice) max_price, 
		min(UnitPrice) min_price,
		max(UnitPrice) - min(UnitPrice) as diff_price
from Products
group by CategoryID
order by diff_price desc

-- вариант 2
select top 1 CategoryID, 
		max(UnitPrice) max_price, 
		min(UnitPrice) min_price
from Products
group by CategoryID
order by max(UnitPrice) - min(UnitPrice) desc

-- Найдите заказ (OrderID) с самым большим количеством штук (Quantity) товаров в чеке. 
-- Если в заказе несколько разных товаров, то штуки нужно сложить. Какой OrderID у заказа?
select top 1 OrderID, SUM(Quantity) as total_quantity
from [Order Details]
group by OrderID
order by total_quantity desc

-- варинт 2
select top 1 OrderID
from [Order Details]
group by OrderID
order by SUM(Quantity) desc


-- Посчитайте суммарный размер фактической скидки по каждому заказу (не в процентах/не в долях). 
-- У скольких заказов скидка составила больше 3 000?
-- Примечание: В столбце Discount указана скидка в долях. Подумайте как расcчитать фактическую скидку.
select OrderID, sum(UnitPrice * Quantity * (Discount)) as sum_discont
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (Discount)) > 3000
order by sum_discont desc

-- вариант 2
select OrderID
from [Order Details]
group by OrderID
having sum(UnitPrice * Quantity * (Discount)) > 3000
order by sum(UnitPrice * Quantity * (Discount)) desc

--вариант 3
SELECT 
	OrderID, 
	SUM(UnitPrice * Quantity * (Discount)) AS total_discont,
	SUM(UnitPrice * Quantity) -  SUM(UnitPrice * Quantity * (Discount)) as total_price
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity * (1 - Discount)) > 3
ORDER BY total_discont DESC;
