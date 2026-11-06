-- 1. Headline KPIs
SELECT COUNT(*) AS orders,
       SUM(total_amount) AS revenue,
       ROUND(AVG(total_amount), 2) AS avg_order_value,
       SUM(quantity) AS units
FROM retail_sales;

-- 2. Revenue by category
SELECT product_category,
       SUM(total_amount) AS revenue,
       COUNT(*) AS orders,
       ROUND(100.0 * SUM(total_amount) / (SELECT SUM(total_amount) FROM retail_sales), 1) AS revenue_share_pct
FROM retail_sales
GROUP BY product_category
ORDER BY revenue DESC;

-- 3. Monthly revenue with month-over-month growth (LAG)
WITH monthly AS (
    SELECT year_month, SUM(total_amount) AS revenue
    FROM retail_sales
    WHERE year_month < '2024-01'
    GROUP BY year_month
)
SELECT year_month,
       revenue,
       LAG(revenue) OVER (ORDER BY year_month) AS prev_revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY year_month))
             / LAG(revenue) OVER (ORDER BY year_month), 1) AS mom_growth_pct
FROM monthly
ORDER BY year_month;

-- 4. Running (cumulative) revenue
WITH monthly AS (
    SELECT year_month, SUM(total_amount) AS revenue
    FROM retail_sales
    WHERE year_month < '2024-01'
    GROUP BY year_month
)
SELECT year_month,
       revenue,
       SUM(revenue) OVER (ORDER BY year_month) AS running_total
FROM monthly
ORDER BY year_month;

-- 5. Top-selling category in each month (CTE + RANK)
WITH cat_month AS (
    SELECT year_month, product_category, SUM(total_amount) AS revenue
    FROM retail_sales
    WHERE year_month < '2024-01'
    GROUP BY year_month, product_category
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY year_month ORDER BY revenue DESC) AS rnk
    FROM cat_month
)
SELECT year_month, product_category, revenue
FROM ranked
WHERE rnk = 1
ORDER BY year_month;

-- 6. Price tier: share of orders vs share of revenue
SELECT price_tier,
       COUNT(*) AS orders,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM retail_sales), 1) AS order_share_pct,
       SUM(total_amount) AS revenue,
       ROUND(100.0 * SUM(total_amount) / (SELECT SUM(total_amount) FROM retail_sales), 1) AS revenue_share_pct
FROM retail_sales
GROUP BY price_tier;

-- 7. Spending by age group
SELECT age_group,
       COUNT(*) AS orders,
       SUM(total_amount) AS revenue,
       ROUND(AVG(total_amount), 2) AS avg_order_value
FROM retail_sales
GROUP BY age_group
ORDER BY age_group;

-- 8. Category x gender revenue (CASE pivot)
SELECT product_category,
       SUM(CASE WHEN gender = 'Female' THEN total_amount ELSE 0 END) AS female_revenue,
       SUM(CASE WHEN gender = 'Male'   THEN total_amount ELSE 0 END) AS male_revenue
FROM retail_sales
GROUP BY product_category;
