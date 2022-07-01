USE magist;

# we use this list as tech product categories 
#("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts")

# num of all product
SELECT COUNT(*) AS num_of_all_products 
FROM products; 


### num of non tech product and tech products 
SELECT COUNT(*) AS num_of_tech_products,
		(32951- COUNT(*)) AS num_of_non_tech_products
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 
    
# number of sales and amount price of sales items
SELECT COUNT(order_item_id) AS total_sold_items_num,
		ROUND(SUM(price),2) total_sold_items_price
FROM order_items;

### num of sales of non tech product and tech products 
SELECT COUNT(oi.order_item_id) AS tech_sold_items_num,
		(112650- COUNT(oi.order_item_id)) AS non_tech_sold_items_num
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 

### price of non tech product and tech products 
SELECT ROUND(SUM(oi.price)) AS tech_sold_items_price,
		ROUND(13591643.7- SUM(oi.price)) AS non_tech_sold_items_price
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 
    
# What percentage of overall sellers are Tech sellers?

# num of all sellers
SELECT COUNT(seller_id) AS num_of_all_sellers
FROM sellers;

### num of non tech product sellers and tech products sellers
SELECT COUNT(DISTINCT oi.seller_id) AS tech_sellers_num,
		(3095- COUNT(DISTINCT oi.seller_id)) AS non_tech_sellers_num
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 



### this code used to find the populity scale 
## I chose the high 5% of the biggest orders-number of products as a popular product, and the result for this dataset is 11. More than 11-time orders are popular.
-- with product_sells_num AS (
--  SELECT count(order_item_id) as num
--  FROM order_items 
--  GROUP BY product_id
--  ORDER BY 1 DESC
--  )
--  Select * 
--  FROM product_sells_num;
--  #LIMIT 1645;
--  #WHERE SUM(num) > 5632;
--  #LIMIT (5/100) * 112650;


# number of sales and amount price of sales items grouped by season
SELECT COUNT(oi.order_item_id) AS total_sold_items_num,
		ROUND(SUM(oi.price),2) total_sold_items_price, 
        CASE 
			
			WHEN o.order_approved_at between '2016-10-01' AND '2016-12-31 23:59:59' THEN "2016-4"
            WHEN o.order_approved_at between '2017-01-01' AND '2017-03-31 23:59:59' THEN "2017-1"
			WHEN o.order_approved_at between '2017-04-01' AND '2017-06-30 23:59:59' THEN "2017-2"
			WHEN o.order_approved_at between '2017-07-01' AND '2017-09-30 23:59:59' THEN "2017-3"
			WHEN o.order_approved_at between '2017-10-01' AND '2017-12-31 23:59:59' THEN "2017-4"
            WHEN o.order_approved_at between '2018-01-01' AND '2018-03-31 23:59:59' THEN "2018-1"
            WHEN o.order_approved_at between '2018-04-01' AND '2018-06-30 23:59:59' THEN "2018-2"
            #WHEN o.order_approved_at between '2018-07-01' AND '2018-09-30 23:59:59' THEN "2018-3"
            ELSE "OUT OF RANGE"
		END AS season
FROM order_items oi
	LEFT JOIN  orders o
		ON oi.order_id = o.order_id
GROUP BY 3
ORDER BY 3;

# number of sales and amount price of sales tech items grouped by season
SELECT COUNT(oi.order_item_id) AS total_sold_items_num,
		ROUND(SUM(oi.price),2) total_sold_items_price, 
        CASE 
			
			WHEN o.order_approved_at between '2016-10-01' AND '2016-12-31 23:59:59' THEN "2016-4"
            WHEN o.order_approved_at between '2017-01-01' AND '2017-03-31 23:59:59' THEN "2017-1"
			WHEN o.order_approved_at between '2017-04-01' AND '2017-06-30 23:59:59' THEN "2017-2"
			WHEN o.order_approved_at between '2017-07-01' AND '2017-09-30 23:59:59' THEN "2017-3"
			WHEN o.order_approved_at between '2017-10-01' AND '2017-12-31 23:59:59' THEN "2017-4"
            WHEN o.order_approved_at between '2018-01-01' AND '2018-03-31 23:59:59' THEN "2018-1"
            WHEN o.order_approved_at between '2018-04-01' AND '2018-06-30 23:59:59' THEN "2018-2"
            #WHEN o.order_approved_at between '2018-07-01' AND '2018-09-30 23:59:59' THEN "2018-3"
            ELSE "OUT OF RANGE"
		END AS season
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
	LEFT JOIN  orders o
		ON oi.order_id = o.order_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts")
GROUP BY 3
ORDER BY 3;


# number of sales and amount price of sales items grouped by month
SELECT COUNT(oi.order_item_id) AS total_sold_items_num,
		ROUND(SUM(oi.price),2) total_sold_items_price, 
        CONCAT(YEAR(o.order_approved_at), "-", MONTH(o.order_approved_at)) AS month
FROM order_items oi
	LEFT JOIN  orders o
		ON oi.order_id = o.order_id
GROUP BY YEAR(o.order_approved_at), MONTH(o.order_approved_at)
ORDER BY YEAR(o.order_approved_at), MONTH(o.order_approved_at);

# number of sales and amount price of sales tech items grouped by month
SELECT COUNT(oi.order_item_id) AS total_sold_items_num,
		ROUND(SUM(oi.price),2) total_sold_items_price,
        CONCAT(YEAR(o.order_approved_at), "-", MONTH(o.order_approved_at)) AS month
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
	LEFT JOIN  orders o
		ON oi.order_id = o.order_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts")
GROUP BY YEAR(o.order_approved_at), MONTH(o.order_approved_at)
ORDER BY YEAR(o.order_approved_at), MONTH(o.order_approved_at);

#the average price of all products
SELECT ROUND(AVG(price)) AS average_price
FROM order_items; 


#the average price of tech products
SELECT ROUND(AVG(oi.price)) AS tech_average_price
FROM products p
	LEFT JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	RIGHT JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 




### num of non tech product and non tech products 
SELECT COUNT(oi.order_item_id) AS tech_sold_items_num,
		(112650- COUNT(oi.order_item_id)) AS non_tech_sold_items_num
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 



########## what is the share of expensive tech products in magist?

## i think we can show three diagram here, with expensive scale
## 1. expensive: more than average of magist tech products (132)
## 2. expensive: more than average of eniac tech products (540)
## 2. expensive: more than average of both average(132+540)/2 =(336)
## and in all of this three, magist isnt good.
### num of expensive non tech product and expensive tech products 
SELECT COUNT(oi.order_item_id) AS tech_sold_items_num,
		(112650- COUNT(oi.order_item_id)) AS non_tech_sold_items_num
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE oi.price >540
	AND pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 
    
    

### are the expensive tech product popular

with product_sells_num AS (
SELECT product_id , count(order_item_id) as num_of_sales
FROM order_items 
GROUP BY 1
ORDER BY 2 DESC
)
SELECT COUNT(p.product_id) AS num_of_popular_expensive_products
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
	JOIN product_sells_num psn
		ON p.product_id = psn.product_id
WHERE oi.price >540 AND psn.num_of_sales > 11
	AND pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 




#the number of delayed products vs on time products

# number of delivered orders
SELECT COUNT(*) AS all_delivered
FROM orders
WHERE order_status = "delivered";

# number of delayed vs on time
SELECT COUNT(*) AS on_time_delivered,
	(96478 - COUNT(*)) AS delayed_delivered
FROM orders
WHERE order_status = "delivered"
	AND DATEDIFF( order_delivered_customer_date, order_estimated_delivery_date) <=0;





### number of cheap vs expensive tech products sold
SELECT COUNT(oi.order_item_id) AS tech_expensive_sold_items_num,
		(21979- COUNT(oi.order_item_id)) AS tech_cheap_sold_items_num
FROM products p
	JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE oi.price >540
	AND pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts"); 



#the average price of tech products grouped by catrgory
SELECT pcnt.product_category_name_english AS category_name,
 ROUND(AVG(oi.price)) AS category_average_price
FROM products p
	LEFT JOIN product_category_name_translation pcnt
		ON p.product_category_name = pcnt.product_category_name
	RIGHT JOIN order_items oi
		ON p.product_id = oi.product_id
WHERE pcnt.product_category_name_english 
	IN ("audio", "computers", "computers_accessories","electronics","signaling_and_security", "tablets_printing_image", "telephony", "watches_gifts")
GROUP BY 1; 