---------------------------------------------------------------------------------
/*1-get customers names and the order data and the required date*/

SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,
    o.order_date,
    o.required_date
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id;
---------------------------------------------------------------------------------
/*2-display customers names, quantity and the discount */

   SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,
    oi.quantity,
    oi.discount
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id;
---------------------------------------------------------------------------------
/*3-Get the store name and the full name of the employee assigned to each store where store id = 1*/

SELECT 
    s.store_name,
    st.first_name + ' ' + st.last_name AS staff_name
FROM sales.stores AS s
JOIN sales.staffs AS st
    ON s.store_id = st.store_id
WHERE s.store_id = 1;
---------------------------------------------------------------------------------
/*4-What are the products and the quantity that our customers bought in 2016?*/

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM sales.orders AS o
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
JOIN production.products AS p
    ON oi.product_id = p.product_id
WHERE YEAR(o.order_date) = 2016
GROUP BY p.product_name
ORDER BY total_quantity DESC;
----------------------------------------------------------------------------------
/*5-Find out the average order value per customer*/

SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    AVG(oi.quantity * oi.list_price * (1 - oi.discount)) AS avg_order_value
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;
----------------------------------------------------------------------------------
/*6-Calculate the total sales amount per store*/

SELECT 
    s.store_id,
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM sales.stores AS s
JOIN sales.staffs AS st
    ON s.store_id = st.store_id
JOIN sales.orders AS o
    ON st.staff_id = o.staff_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY s.store_id, s.store_name
ORDER BY total_sales DESC;
-----------------------------------------------------------------------------------
/*7-List top-selling products (by quantity) and their total sales amount*/

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM sales.order_items AS oi
JOIN production.products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;
-----------------------------------------------------------------------------------
/*8-count the number of products in each category*/

SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM production.categories AS c
JOIN production.products AS p
    ON c.category_id = p.category_id
GROUP BY c.category_name;
-----------------------------------------------------------------------------------
/*9-List staff members who generated the highest total sales amount*/

SELECT 
    st.staff_id,
    st.first_name + ' ' + st.last_name AS staff_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM sales.staffs AS st
JOIN sales.orders AS o
    ON st.staff_id = o.staff_id
JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY st.staff_id, st.first_name, st.last_name
ORDER BY total_sales DESC;
-----------------------------------------------------------------------------------
/*10-Identify customers who made the highest number of orders*/

SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    COUNT(o.order_id) AS order_count
FROM sales.customers AS c
JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY order_count DESC;
-----------------------------------------------------------------------------------