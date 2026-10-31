/*-----------------------------------------------------------------------------
								SILVER LAYER
This silver layer analysis duplicated data, missing value, or invalid value
-----------------------------------------------------------------------------*/

/*===========================================================================*/
-- 1) Checking number of data each table
SELECT COUNT(*)
FROM bronze_customer_master;

SELECT COUNT(*)
FROM bronze_ecommerce_sales_customer;

SELECT COUNT(*) 
FROM bronze_order_items;

SELECT COUNT(*)
FROM bronze_product_catalog;

/*===========================================================================*/
-- 2) Checking duplicate data
SELECT customer_id, COUNT(*)
FROM bronze_customer_master
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*)
FROM bronze_ecommerce_sales_customer
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM bronze_product_catalog
GROUP BY product_id
HAVING COUNT(*) > 1;

/*===========================================================================*/
-- 3) Searching missing value
SELECT *
FROM bronze_ecommerce_sales_customer
WHERE order_id IS NULL OR order_id = ''
OR order_status IS NULL OR order_status = ''
OR customer_id IS NULL OR customer_id = '';

/*===========================================================================*/
-- 4) Searching Invalid Values
SELECT *
FROM bronze_ecommerce_sales_customer eco
JOIN bronze_order_items ord
ON eco.order_id = ord.order_id
WHERE eco.order_id IS NULL OR eco.order_id = ''
OR ord.order_id IS NULL OR ord.order_id = '';

SELECT *
FROM bronze_customer_master eco
JOIN bronze_customer_master cus
ON eco.customer_id = cus.customer_id
WHERE eco.customer_id IS NULL OR eco.customer_id = ''
OR cus.customer_id IS NULL OR cus.customer_id = '';

SELECT *
FROM bronze_order_items ord
JOIN bronze_product_catalog prd
ON ord.product_id = prd.product_id
WHERE ord.product_id IS NULL OR ord.product_id = ''
OR prd.product_id IS NULL OR prd.product_id = '';

SELECT 
	gross_sales,
    tax_amount,
    shipping_cost,
    discount_amount,
    gross_sales-discount_amount AS net_sales,
    gross_sales-discount_amount+tax_amount+shipping_cost AS order_sales,
    product_cost,
    gross_sales-product_cost-discount_amount AS profit
FROM bronze_ecommerce_sales_customer
WHERE order_status = 'Completed'
LIMIT 20;