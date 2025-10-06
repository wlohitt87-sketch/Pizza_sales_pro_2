# PIZZA SALES ANALYSIS SQL PROJECT

## Project Overview

**Project Title**: Pizza Sales Analysis

**Database**: Pizza_hut_pro_2

The purpose of this project is to showcase the SQL abilities and methods that data analysts commonly employ to examine, purify, and evaluate retail sales data. Setting up a retail sales database, conducting exploratory data analysis (EDA), and using SQL queries to address certain business concerns are all part of the project. For individuals who are just beginning their data analysis career and wish to establish a strong foundation in SQL, this project is perfect.

## Objectives

 1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
 2. **Data Cleaning**: Identify and remove any records with missing or null values.
 3. **Exploratory Data Analysis (EDA)**: Use simple exploratory data analysis to gain insight into the dataset.
 4. **Business Analysis**: Utilize SQL to extract insights from the sales data and provide answers to particular business issues.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named Pizza_hut_pro_2.
- **Table Creation**: There are 4 table that created to store data called 'order_details', 'orders', 'pizza_types', 'pizzas'.

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```
SELECT COUNT (*)
FROM [dbo].[order_details]
```

```
SELECT COUNT (*)
FROM [dbo].[orders]
```

```
SELECT COUNT (*)
FROM [dbo].[pizza_types]
```

```
SELECT COUNT (*)
FROM [dbo].[pizzas
```
**--check the NULL values from each tables**

```
SELECT * FROM [dbo].[order_details]
WHERE order_id IS NULL
	  OR
	  pizza_id IS NULL
	  OR
	  quantity IS NULL
```

```
SELECT * FROM [dbo].[orders]
WHERE order_id IS NULL
	  OR
	  date IS NULL
	  OR
	  time IS NULL
```

```
SELECT * FROM [dbo].[pizza_types]
WHERE pizza_type_id IS NULL
	  OR
	  name IS NULL
	  OR
	  category IS NULL
	  OR
	  ingredients IS NULL
```

```
SELECT * FROM [dbo].[pizzas]
WHERE pizza_id IS NULL
	  OR
	  pizza_type_id IS NULL
	  OR
	  size IS NULL
	  OR
	  price IS NULL
```

**--There is no NULL value available in these tables**


### 3. Data Analysis & Business key problems & Answers 


**--1.Retrieve the total number of orders placed.**
```
SELECT COUNT(order_id) AS Total_sales
FROM [dbo].[orders]
```
**--2.Calculate the total revenue generated from pizza sales.**
```
SELECT ROUND(
SUM(order_details.quantity * pizzas.price),2)
AS Total_revenue9
FROM [dbo].[order_details] JOIN [dbo].[pizzas]
ON order_details.pizza_id = pizzas.pizza_id
```
**--3. Identify the highest-priced pizza.**
```
1.SELECT TOP 1 pizza_id, ROUND (price,2) AS Highest_priced_pizza
FROM [dbo].[pizzas]
ORDER BY price DESC
```
```
2.SELECT pizza_id, ROUND (price,2) AS Highest_priced_pizza
FROM [dbo].[pizzas]
WHERE price = (SELECT MAX(price) FROM [dbo].[pizzas])
```
