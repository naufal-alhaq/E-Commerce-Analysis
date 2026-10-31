/*-----------------------------------------------------------------------------
								BRONZE LAYER
This bronze layer involves creating tables and importing data into them
-----------------------------------------------------------------------------*/

SET GLOBAL local_infile = 1;

/*===========================================================================*/
-- 1) CUSTOMER MASTER
CREATE TABLE bronze_customer_master(
	customer_id VARCHAR(255),
	customer_name VARCHAR(255),
	customer_age INT,
	gender VARCHAR(25),
	customer_segment VARCHAR(25),
	customer_city VARCHAR(255),
	customer_state VARCHAR(255),
	customer_country VARCHAR(255),
	region VARCHAR(255),
	customer_postal_code VARCHAR(255),
	customer_acquisition_cost FLOAT
);

TRUNCATE TABLE bronze_customer_master;
LOAD DATA LOCAL INFILE "/customer_master.csv"
INTO TABLE bronze_customer_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*===========================================================================*/
-- 2) ECOMMERCE SALES CUSTOMER
CREATE TABLE bronze_ecommerce_sales_customer(
	order_id VARCHAR(255),
	order_date DATE,
	order_time TIME,
	order_status VARCHAR(50),
	sales_channel VARCHAR(50),
	customer_id VARCHAR(255),
	customer_name VARCHAR(255),
	customer_age INT,
	gender VARCHAR(50),
	customer_segment VARCHAR(50),
	customer_type VARCHAR(50),
	customer_city VARCHAR(255),
	customer_state VARCHAR(255),
	customer_country VARCHAR(50),
	region VARCHAR(50),
	customer_postal_code VARCHAR(255),
	payment_method VARCHAR(255),
	payment_status VARCHAR(50),
	currency VARCHAR(50),
	shipping_method VARCHAR(50),
	warehouse VARCHAR(50),
	delivery_days INT,
	estimated_delivery_days VARCHAR(50),
	delivery_status VARCHAR(50),
	return_status VARCHAR(50),
	return_reason VARCHAR(50),
	customer_rating DECIMAL(10,2),
	review_sentiment VARCHAR(50),
	customer_review TEXT,
	marketing_channel VARCHAR(50),
	campaign_name VARCHAR(50),
	coupon_code VARCHAR(50),
	loyalty_points_earned INT,
	loyalty_points_redeemed INT,
	quantity INT,
	gross_sales DECIMAL(10,2),
	discount_amount DECIMAL(10,2),
	tax_amount DECIMAL(10,2),
	shipping_cost DECIMAL(10,2),
	net_sales DECIMAL(10,2),
	product_cost DECIMAL(10,2),
	profit DECIMAL(10,2),
	profit_margin_percentage VARCHAR(50),
	customer_lifetime_value DECIMAL(10,2),
	is_repeat_customer VARCHAR(50),
	customer_order_count INT
);

TRUNCATE TABLE bronze_ecommerce_sales_customer;
LOAD DATA LOCAL INFILE "/ecommerce_sales_customer_analytics_150k.csv"
INTO TABLE bronze_ecommerce_sales_customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id, @order_date, @order_time, @order_status, @sales_channel, @customer_id, @customer_name, @customer_age, @gender, @customer_segment, @customer_type, @customer_city, @customer_state, @customer_country, @region, @customer_postal_code, @payment_method, @payment_status, @currency, @shipping_method, @warehouse, @delivery_days, @estimated_delivery_days, @delivery_status, @return_status, @return_reason, @customer_rating, @review_sentiment, @customer_review, @marketing_channel, @campaign_name, @coupon_code, @loyalty_points_earned, @loyalty_points_redeemed, @quantity, @gross_sales, @discount_amount, @tax_amount, @shipping_cost, @net_sales, @product_cost, @profit, @profit_margin_percentage, @customer_lifetime_value, @is_repeat_customer, @customer_order_count)
SET
	order_id = NULLIF(@order_id, ''),
	order_date = NULLIF(@order_date, ''),
	order_time = NULLIF(@order_time, ''),
	order_status = NULLIF(@order_status, ''),
	sales_channel = NULLIF(@sales_channel, ''),
	customer_id = NULLIF(@customer_id, ''),
	customer_name = NULLIF(@customer_name, ''),
	customer_age = NULLIF(@customer_age, ''),
	gender = NULLIF(@gender, ''),
	customer_segment = NULLIF(@customer_segment, ''),
	customer_type = NULLIF(@customer_type, ''),
	customer_city = NULLIF(@customer_city, ''),
	customer_state = NULLIF(@customer_state, ''),
	customer_country = NULLIF(@customer_country, ''),
	region = NULLIF(@region, ''),
	customer_postal_code = NULLIF(@customer_postal_code, ''),
	payment_method = NULLIF(@payment_method, ''),
	payment_status = NULLIF(@payment_status, ''),
	currency = NULLIF(@currency, ''),
	shipping_method = NULLIF(@shipping_method, ''),
	warehouse = NULLIF(@warehouse, ''),
	delivery_days = NULLIF(@delivery_days, ''),
	estimated_delivery_days = NULLIF(@estimated_delivery_days, ''),
	delivery_status = NULLIF(@delivery_status, ''),
	return_status = NULLIF(@return_status, ''),
	return_reason = NULLIF(@return_reason, ''),
	customer_rating = NULLIF(@customer_rating, ''),
	review_sentiment = NULLIF(@review_sentiment, ''),
	customer_review = NULLIF(@customer_review, ''),
	marketing_channel = NULLIF(@marketing_channel, ''),
	campaign_name = NULLIF(@campaign_name, ''),
	coupon_code = NULLIF(@coupon_code, ''),
	loyalty_points_earned = NULLIF(@loyalty_points_earned, ''),
	loyalty_points_redeemed = NULLIF(@loyalty_points_redeemed, ''),
	quantity = NULLIF(@quantity, ''),
	gross_sales = NULLIF(@gross_sales, ''),
	discount_amount = NULLIF(@discount_amount, ''),
	tax_amount = NULLIF(@tax_amount, ''),
	shipping_cost = NULLIF(@shipping_cost, ''),
	net_sales = NULLIF(@net_sales, ''),
	product_cost = NULLIF(@product_cost, ''),
	profit = NULLIF(@profit, ''),
	profit_margin_percentage = NULLIF(@profit_margin_percentage, ''),
	customer_lifetime_value = NULLIF(@customer_lifetime_value, ''),
	is_repeat_customer = NULLIF(@is_repeat_customer, ''),
	customer_order_count = NULLIF(@customer_order_count, '');

/*===========================================================================*/
-- 3) ORDER ITEMS
CREATE TABLE bronze_order_items(
	order_id VARCHAR(50),
	product_id VARCHAR(50), 
	quantity INT,
	unit_price DECIMAL(10,2),
	discount_percentage DECIMAL(10,5),
	discount_amount DECIMAL(10,2),
	gross_sales DECIMAL(10,2),
	tax_amount DECIMAL(10,2),
	shipping_cost DECIMAL(10,2),
	net_sales DECIMAL(10,2),
	product_cost DECIMAL(10,2),
	profit DECIMAL(10,2)
);

TRUNCATE TABLE bronze_order_items;
LOAD DATA LOCAL INFILE "/order_items.csv"
INTO TABLE bronze_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*===========================================================================*/
-- 4) PRODUCT CATALOG
CREATE TABLE bronze_product_catalog(
	product_id VARCHAR(50),
	product_name TEXT,
	product_category VARCHAR(50),
	product_subcategory VARCHAR(50),
	brand VARCHAR(50),
	supplier VARCHAR(50),
	unit_price DECIMAL(10,2),
	product_cost DECIMAL(10,2),
	product_rating DECIMAL(10,1)
);

LOAD DATA LOCAL INFILE "/product_catalog.csv"
INTO TABLE bronze_product_catalog
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;