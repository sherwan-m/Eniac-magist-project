USE magist;
# 1:
SELECT COUNT(*) AS order_count
FROM orders;

# 2:
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY 1;

# 3:
SELECT YEAR(order_purchase_timestamp) AS year, 
		MONTH(order_purchase_timestamp) AS month,
		COUNT(customer_id) AS order_count
FROM orders
GROUP BY 1, 2
ORDER BY 1, 2;

# 4:
SELECT DISTINCT COUNT(product_id)
FROM products;

SELECT COUNT(DISTINCT product_id)
FROM products;

# 5:
SELECT product_category_name , COUNT(product_id) AS count_products
FROM products 
GROUP BY 1
ORDER BY 2 DESC;

# 6:
SELECT COUNT(DISTINCT product_id) AS items_in_order
FROM order_items;

# 7:
SELECT MAX(price) AS most_expensive, MIN(price) AS cheapest 
FROM order_items;

# 8:
SELECT MAX(payment_value) AS highest , MIN(payment_value) AS lowest
FROM order_payments;
