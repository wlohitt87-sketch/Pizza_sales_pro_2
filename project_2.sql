USE [Pizza_hut]

-- check the NULL values from each tables

SELECT * FROM [dbo].[order_details]
WHERE order_id IS NULL
	  OR
	  pizza_id IS NULL
	  OR
	  quantity IS NULL

SELECT * FROM [dbo].[orders]
WHERE order_id IS NULL
	  OR
	  date IS NULL
	  OR
	  time IS NULL

SELECT * FROM [dbo].[pizza_types]
WHERE pizza_type_id IS NULL
	  OR
	  name IS NULL
	  OR
	  category IS NULL
	  OR
	  ingredients IS NULL

SELECT * FROM [dbo].[pizzas]
WHERE pizza_id IS NULL
	  OR
	  pizza_type_id IS NULL
	  OR
	  size IS NULL
	  OR
	  price IS NULL

-- There is no NULL value available in these tables


--Data Analysis & Business key problems & Answers 

--1.Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS Total_sales
FROM [dbo].[orders]

--2.Calculate the total revenue generated from pizza sales.

SELECT ROUND(
SUM(order_details.quantity * pizzas.price),2)
AS Total_revenue9
FROM [dbo].[order_details] JOIN [dbo].[pizzas]
ON order_details.pizza_id = pizzas.pizza_id

--3. Identify the highest-priced pizza.

SELECT TOP 1 pizza_id, ROUND (price,2) AS Highest_priced_pizza
FROM [dbo].[pizzas]
ORDER BY price DESC

SELECT pizza_id, ROUND (price,2) AS Highest_priced_pizza
FROM [dbo].[pizzas]
WHERE price = (SELECT MAX(price) FROM [dbo].[pizzas])

--4.Identify the most common pizza size ordered.

SELECT size, COUNT(size) AS most_common_Size
FROM [dbo].[pizzas]
GROUP BY size
ORDER BY size DESC

--5. List the top 5 most ordered pizza types along with their quantities.

SELECT TOP 5 pizza_types.name, SUM(order_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC

--6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT  pizza_types.category,SUM (order_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC

--7. Determine the distribution of orders by hour of the day.

SELECT DATEPART(HOUR, time) AS HOUR, COUNT(order_id) AS order_id
FROM [dbo].[orders]
GROUP BY DATEPART(HOUR, time)
ORDER BY HOUR

--8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, COUNT(name) AS Distribution_of_pizzas
FROM pizza_types
GROUP BY category

--9. Group the orders by date and calculate the average number of pizzas ordered per day.

WITH DailyPizzaCounts AS (
    SELECT 
        o.date,
        SUM(od.Quantity) AS TotalPizzas
    FROM 
        Orders o
    JOIN 
        order_details od 
	ON o.order_id = od.order_id
    GROUP BY 
        o.date
)

-- Step 2: Calculate average pizzas per day
SELECT 
    AVG(TotalPizzas ) AS AvgPizzasPerDay
FROM 
    DailyPizzaCounts;


-- 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT TOP 3 pt.name, SUM(p.price * od.quantity) AS Revenue
FROM pizza_types pt 
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY Revenue DESC


-- END OF THE PROJECT