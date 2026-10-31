# E-Commerce-Analysis
# E-Commerce Analysis: Discount Depth and Profit Margin

An analysis of year-end sales performance for an online store. November–December revenue jumps every year, but profit does not follow. This project finds out why and recommends a discount policy that protects margin.

**Tools:** SQL, Power BI (DAX), PowerPoint

---

## Business Problem

The business runs heavy promotions every November–December. Monthly revenue is **70.8% higher** than in January–October, yet monthly profit is **4.5% lower**, even with 60.7% more orders. The extra sales are not turning into extra earnings.

**Core question:** is the profit gap caused by discount depth, or by something else such as costs, shipping, coupons or cancellations?

## Objectives

1. Explain why year-end revenue growth does not become profit growth.
2. Measure the gap: compare revenue, orders, profit and margin in Nov–Dec against Jan–Oct.
3. Locate the cause: show how profit margin changes across discount bands.
4. Recommend a discount policy that protects margin.

## Key Findings

Monthly averages, Completed orders only, 2021–2025.

| Metric | Jan–Oct | Nov–Dec | Change |
| --- | --- | --- | --- |
| Revenue per month | $1.91M | $3.26M | +70.82% |
| Orders per month | 1,719 | 2,763 | +60.74% |
| Profit per month | $772K | $738K | −4.50% |
| Profit margin | 40.51% | 22.65% | −17.86 pts |

- **Margin falls as discount deepens.** Margin is 44.58% at 0–10% discount, 20.58% at 31–40%, and −15.37% at 51–60%.
- **Nov–Dec orders shift to deep discounts.** Orders above 30% discount rise from 1.9% (Jan–Oct) to 54.5% (Nov–Dec).
- **Deep discounts give away profit.** Bands above 30% discount hold 15.6% of revenue but only 6.4% of profit. Their combined margin is 14.7%, against 39.9% for orders discounted up to 30%.
- **Volume is cancelled by margin.** More orders add about $469K a month, but lower profit per order removes about $503K (rounded figures).

## Recommendations

| Priority | Recommendation | Expected Business Impact |
| --- | --- | --- |
| High | Cap the maximum discount at 30% | Avoid the 14.7% margin earned above 30% discount |
| High | Stop discounts above 50% | Remove the 51–60% band, which loses money (−$190,672 profit) |
| Medium | Make 11–20% the default year-end depth | Keep margin near 39.58% with a visible promotion |
| Medium | A/B test 15% vs 25% year-end discounts | Measure the extra orders deeper discounts really win |

## Dataset

| Item | Detail |
| --- | --- |
| Source | E-Commerce Sales Analytics Dataset (https://www.kaggle.com/datasets/datascikhan/e-commerce-sales-and-customer-analytics) |
| Size | 138,116 orders, 46 columns |
| Period | January 2021 – December 2025 |
| Currency | Mixed currencies, summed at face value without conversion |

The 46 columns fall into 11 categories: order, customer profile, geography, payment, shipping and logistics, returns, customer feedback, marketing and promotion, loyalty, sales and financials, and customer value and behavior.

## Data Pipeline

The SQL scripts follow a Bronze / Silver / Gold layering.

| Layer | Script | Purpose |
| --- | --- | --- |
| Bronze | `bronze_layer_ecommerce_analysis.sql` | [Raw load of the source data] |
| Silver | `silver_layer_ecommerce_analysis.sql` | [Cleaning, data types, recalculated `net_sales` and `profit`, derived columns] |
| Gold | `gold_layer_ecommerce_analysis.sql` | [Analysis-ready tables for the dashboard] |

### Data preparation

- **Duplicates:** none found; every `order_id` is unique.
- **Missing values:** gaps are structural and kept (delivery and review fields for orders that were not completed, return, coupon and campaign fields when not applicable).
- **Transformation:** formats standardized; `net_sales` recalculated as `gross_sales − discount_amount`; `profit` recalculated as `net_sales − product_cost`.
- **Feature engineering:** `order_sales`, `Disc %`, `Discount Band`, `Year`, `Month No`, `Year-Month`, `Period` (Jan–Oct vs Nov–Dec).
- **Filtering:** Cancelled, Pending and Returned orders excluded, leaving Completed orders only.
- **Feature selection:** personal data (`customer_name`, `customer_postal_code`) and review text left out.

## Dashboard

A two-page Power BI dashboard:

1. **Executive Summary:** four KPI cards, revenue and profit trend, margin and discount by month.
2. **Analysis:** margin and order share by discount band, margin against discount %, and a band performance table.

The full dashboard is in `dashboard_ecommerce_sales_analysis.pdf`.

## Repository Structure

```
E-Commerce-Analysis/
├── README.md
├── bronze_layer_ecommerce_analysis.sql
├── silver_layer_ecommerce_analysis.sql
├── gold_layer_ecommerce_analysis.sql
├── dashboard_ecommerce_sales_analysis.pdf
└── Discount Depth and Profit Margin: An Analysis of Year-End Sales Performance.pdf
```

## Limitations

- The link between discount and margin is partly built into the formula, since margin is calculated after discount. It shows association; an A/B test would give stronger evidence of cause.
- The data does not show how many orders deep discounts actually win, so volume lost from a discount cap is unknown.
- Mixed currencies are summed without conversion, so dollar figures are indicative. Comparisons between periods remain valid.
- Results are overall averages; products, categories and channels may behave differently.

## Author

**Naufal al-Haq**
**Email:** naufalalhaq4@gmail.com
