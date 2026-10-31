/*-----------------------------------------------------------------------------
								GOLD LAYER
This gold layer loads data that has been cleaned
-----------------------------------------------------------------------------*/

/*===========================================================================*/
-- 1) CUSTOMER MASTER
INSERT INTO gold_customer_master(
customer_id, customer_name, customer_age, gender, customer_segment, customer_city, customer_state, customer_country, region,
customer_postal_code, customer_acquisition_cost)
SELECT 
	customer_id,
    customer_name,
    customer_age,
    gender,
    customer_segment,
    customer_city,
    customer_state,
    customer_country,
    region,
    customer_postal_code,
    customer_acquisition_cost
FROM bronze_customer_master;

/*===========================================================================*/
-- 2) E-COMMERCE SALES CUSTOMER
INSERT INTO gold_ecommerce_sales_customer(
order_id, order_date, order_time, order_status, sales_channel, customer_id, customer_type, payment_method, payment_status, currency,
shipping_method, warehouse, delivery_days, estimated_delivery_days, delivery_status, return_status, return_reason, customer_rating,
review_sentiment, customer_review, marketing_channel, campaign_name, coupon_code, loyalty_points_earned, loyalty_points_redeemed,
quantity, gross_sales, discount_amount, tax_amount, shipping_cost, net_sales, order_sales, product_cost, profit, profit_margin_percentage,
customer_lifetime_value, is_repeat_customer, customer_order_count)
SELECT 
	order_id,
    order_date,
    order_time,
    order_status,
    sales_channel,
    customer_id,
    customer_type,
    payment_method,
    payment_status,
    currency,
    shipping_method,
    warehouse,
    delivery_days,
    estimated_delivery_days,
    delivery_status,
    return_status,
    return_reason,
    customer_rating,
    review_sentiment,
    customer_review,
    marketing_channel,
    campaign_name,
    coupon_code,
    loyalty_points_earned,
    loyalty_points_redeemed,
    quantity,
    gross_sales,
    discount_amount,
    tax_amount,
    shipping_cost,
    gross_sales-discount_amount AS net_sales,
    gross_sales-discount_amount+tax_amount+shipping_cost AS order_sales,
    product_cost,
    gross_sales-discount_amount-product_cost AS profit,
    ROUND((gross_sales-discount_amount-product_cost)/(gross_sales-discount_amount)*100, 2) AS profit_margin_percentage,
    customer_lifetime_value,
    is_repeat_customer,
    customer_order_count
FROM bronze_ecommerce_sales_customer;

-- 3) ORDER ITEMS
INSERT INTO gold_order_items(
order_id, product_id, quantity, unit_price, discount_percentage, discount_amount, gross_sales, tax_amount, shipping_cost, 
net_sales, product_cost, profit)
SELECT 
	order_id,
    product_id,
    quantity,
    unit_price,
    discount_percentage,
    discount_amount,
    gross_sales,
    tax_amount,
    shipping_cost,
    net_sales,
    product_cost,
    profit
FROM bronze_order_items;

-- 4) PRODUCT CATALOG
INSERT INTO gold_product_catalog(
product_id, product_name, product_category, product_subcategory, brand, supplier, unit_price, product_cost, product_rating)
SELECT 
	product_id,
    product_name,
    product_category,
    product_subcategory,
    brand,
    supplier,
    unit_price,
    product_cost,
    product_rating
FROM bronze_product_catalog;