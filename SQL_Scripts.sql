
-- ================================================================
-- PROJECT: Pharmaceutical Sales Performance & Market Analytics
-- DATABASE: pharma_analytics
-- TABLE: pharma_sales_analytics_dataset
-- DIALECT: MySQL 8.0+
-- ================================================================

USE pharma_analytics;

-- 1. DATA OVERVIEW
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Order_ID) AS total_orders,
    MIN(`Date`) AS first_order_date,
    MAX(`Date`) AS last_order_date,
    COUNT(DISTINCT Region) AS total_regions,
    COUNT(DISTINCT Drug) AS total_drugs,
    COUNT(DISTINCT Sales_Rep_ID) AS total_sales_reps,
    COUNT(DISTINCT Channel) AS total_channels,
    COUNT(DISTINCT Customer_Segment) AS total_customer_segments
FROM pharma_sales_analytics_dataset;

-- 2. DATA QUALITY CHECKS
SELECT
    SUM(Order_ID IS NULL) AS null_order_ids,
    SUM(`Date` IS NULL) AS null_dates,
    SUM(Region IS NULL OR TRIM(Region) = '') AS missing_regions,
    SUM(Drug IS NULL OR TRIM(Drug) = '') AS missing_drugs,
    SUM(Sales_Rep_ID IS NULL OR TRIM(Sales_Rep_ID) = '') AS missing_sales_reps,
    SUM(Units_Sold IS NULL) AS null_units,
    SUM(Unit_Price_USD IS NULL) AS null_unit_prices,
    SUM(Sales_Revenue_USD IS NULL) AS null_revenue,
    SUM(Sales_Target_USD IS NULL) AS null_targets
FROM pharma_sales_analytics_dataset;

-- 3. DUPLICATE ORDER ID CHECK
SELECT
    Order_ID,
    COUNT(*) AS row_count
FROM pharma_sales_analytics_dataset
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 4. REVENUE CALCULATION VALIDATION
SELECT
    COUNT(*) AS rows_checked,
    SUM(
        ABS(Sales_Revenue_USD - Units_Sold * Unit_Price_USD) > 0.02
    ) AS revenue_mismatch_rows
FROM pharma_sales_analytics_dataset
WHERE Units_Sold IS NOT NULL
  AND Unit_Price_USD IS NOT NULL
  AND Sales_Revenue_USD IS NOT NULL;

-- 5. OVERALL BUSINESS KPIs
SELECT
    ROUND(SUM(Sales_Revenue_USD), 2) AS total_revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS total_target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS total_units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(
        SUM(Sales_Revenue_USD)
        / NULLIF(COUNT(DISTINCT Order_ID), 0), 2
    ) AS average_revenue_per_order_usd
FROM pharma_sales_analytics_dataset;

-- 6. MONTHLY REVENUE VS TARGET
SELECT
    DATE_FORMAT(`Date`, '%Y-%m') AS sales_month,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
FROM pharma_sales_analytics_dataset
GROUP BY DATE_FORMAT(`Date`, '%Y-%m')
ORDER BY sales_month;

-- 7. YEARLY PERFORMANCE AND YEAR-OVER-YEAR GROWTH
WITH yearly AS (
    SELECT
        YEAR(`Date`) AS sales_year,
        SUM(Sales_Revenue_USD) AS revenue_usd,
        SUM(Sales_Target_USD) AS target_usd,
        SUM(Units_Sold) AS units_sold
    FROM pharma_sales_analytics_dataset
    GROUP BY YEAR(`Date`)
),
yearly_comparison AS (
    SELECT
        sales_year,
        revenue_usd,
        target_usd,
        units_sold,
        LAG(revenue_usd) OVER (
            ORDER BY sales_year
        ) AS previous_year_revenue
    FROM yearly
)
SELECT
    sales_year,
    ROUND(revenue_usd, 2) AS revenue_usd,
    ROUND(target_usd, 2) AS target_usd,
    units_sold,
    ROUND(
        100 * revenue_usd / NULLIF(target_usd, 0), 2
    ) AS target_achievement_pct,
    ROUND(
        100 * (revenue_usd - previous_year_revenue)
        / NULLIF(previous_year_revenue, 0), 2
    ) AS yoy_revenue_growth_pct
FROM yearly_comparison
ORDER BY sales_year;

-- 8. REGION PERFORMANCE
SELECT
    Region,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM pharma_sales_analytics_dataset
GROUP BY Region
ORDER BY revenue_usd DESC;

-- 9. DRUG / PRODUCT PERFORMANCE
SELECT
    Drug,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(
            (SELECT SUM(Sales_Revenue_USD)
             FROM pharma_sales_analytics_dataset), 0
        ), 2
    ) AS revenue_contribution_pct
FROM pharma_sales_analytics_dataset
GROUP BY Drug
ORDER BY revenue_usd DESC;

-- 10. THERAPY AREA PERFORMANCE
SELECT
    Therapy_Area,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM pharma_sales_analytics_dataset
GROUP BY Therapy_Area
ORDER BY revenue_usd DESC;

-- 11. SALES REPRESENTATIVE SCORECARD
SELECT
    Sales_Rep_ID,
    ROUND(SUM(Sales_Revenue_USD), 2) AS total_revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS total_target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(
        SUM(Sales_Revenue_USD)
        / NULLIF(COUNT(DISTINCT Order_ID), 0), 2
    ) AS average_revenue_per_order_usd
FROM pharma_sales_analytics_dataset
GROUP BY Sales_Rep_ID
ORDER BY target_achievement_pct DESC, total_revenue_usd DESC;

-- 12. SALES REPRESENTATIVES BELOW TARGET
SELECT
    Sales_Rep_ID,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
FROM pharma_sales_analytics_dataset
GROUP BY Sales_Rep_ID
HAVING SUM(Sales_Revenue_USD) < SUM(Sales_Target_USD)
ORDER BY target_achievement_pct ASC;

-- 13. SALES CHANNEL PERFORMANCE
SELECT
    Channel,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(
            (SELECT SUM(Sales_Revenue_USD)
             FROM pharma_sales_analytics_dataset), 0
        ), 2
    ) AS revenue_contribution_pct
FROM pharma_sales_analytics_dataset
GROUP BY Channel
ORDER BY revenue_usd DESC;

-- 14. CUSTOMER SEGMENT PERFORMANCE
SELECT
    Customer_Segment,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(
        SUM(Sales_Revenue_USD)
        / NULLIF(COUNT(DISTINCT Order_ID), 0), 2
    ) AS average_revenue_per_order_usd
FROM pharma_sales_analytics_dataset
GROUP BY Customer_Segment
ORDER BY revenue_usd DESC;

-- 15. REGION-WISE DRUG PERFORMANCE
SELECT
    Region,
    Drug,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
FROM pharma_sales_analytics_dataset
GROUP BY Region, Drug
ORDER BY target_achievement_pct ASC, revenue_usd DESC;

-- 16. MONTHS BELOW TARGET
SELECT
    DATE_FORMAT(`Date`, '%Y-%m') AS sales_month,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
FROM pharma_sales_analytics_dataset
GROUP BY DATE_FORMAT(`Date`, '%Y-%m')
HAVING SUM(Sales_Revenue_USD) < SUM(Sales_Target_USD)
ORDER BY revenue_variance_usd ASC;

-- 17. DRUG PERFORMANCE BY CHANNEL
SELECT
    Drug,
    Channel,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold
FROM pharma_sales_analytics_dataset
GROUP BY Drug, Channel
ORDER BY Drug, revenue_usd DESC;

-- 18. TOP 10 SALES REPRESENTATIVES BY REVENUE
SELECT
    Sales_Rep_ID,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM pharma_sales_analytics_dataset
GROUP BY Sales_Rep_ID
ORDER BY revenue_usd DESC
LIMIT 10;

-- 19. TOP 5 AND BOTTOM 5 REPRESENTATIVES
(SELECT
    'Top performer' AS performance_group,
    Sales_Rep_ID,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
 FROM pharma_sales_analytics_dataset
 GROUP BY Sales_Rep_ID
 ORDER BY target_achievement_pct DESC
 LIMIT 5)
UNION ALL
(SELECT
    'Bottom performer' AS performance_group,
    Sales_Rep_ID,
    ROUND(SUM(Sales_Revenue_USD), 2) AS revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS target_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct
 FROM pharma_sales_analytics_dataset
 GROUP BY Sales_Rep_ID
 ORDER BY target_achievement_pct ASC
 LIMIT 5);

-- 20. EXECUTIVE SUMMARY
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Sales_Rep_ID) AS total_sales_reps,
    ROUND(SUM(Sales_Revenue_USD), 2) AS total_revenue_usd,
    ROUND(SUM(Sales_Target_USD), 2) AS total_target_usd,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    SUM(Units_Sold) AS total_units_sold,
    ROUND(
        SUM(Sales_Revenue_USD)
        / NULLIF(COUNT(DISTINCT Order_ID), 0), 2
    ) AS average_revenue_per_order_usd
FROM pharma_sales_analytics_dataset;

-- 21. CATEGORY VALIDATION
SELECT
    'Region' AS category_field,
    Region AS category_value,
    COUNT(*) AS row_count
FROM pharma_sales_analytics_dataset
GROUP BY Region

UNION ALL

SELECT 'Drug', Drug, COUNT(*)
FROM pharma_sales_analytics_dataset
GROUP BY Drug

UNION ALL

SELECT 'Therapy_Area', Therapy_Area, COUNT(*)
FROM pharma_sales_analytics_dataset
GROUP BY Therapy_Area

UNION ALL

SELECT 'Sales_Rep_ID', Sales_Rep_ID, COUNT(*)
FROM pharma_sales_analytics_dataset
GROUP BY Sales_Rep_ID

UNION ALL

SELECT 'Channel', Channel, COUNT(*)
FROM pharma_sales_analytics_dataset
GROUP BY Channel

UNION ALL

SELECT 'Customer_Segment', Customer_Segment, COUNT(*)
FROM pharma_sales_analytics_dataset
GROUP BY Customer_Segment
ORDER BY category_field, row_count DESC;

-- 22. REVENUE VS TARGET BY SALES REPRESENTATIVE
-- Useful as a scatter-plot data source
SELECT
    Sales_Rep_ID,
    ROUND(SUM(Sales_Target_USD), 2) AS total_target_usd,
    ROUND(SUM(Sales_Revenue_USD), 2) AS total_revenue_usd,
    ROUND(
        100 * SUM(Sales_Revenue_USD)
        / NULLIF(SUM(Sales_Target_USD), 0), 2
    ) AS target_achievement_pct,
    ROUND(
        SUM(Sales_Revenue_USD) - SUM(Sales_Target_USD), 2
    ) AS revenue_variance_usd
FROM pharma_sales_analytics_dataset
GROUP BY Sales_Rep_ID
ORDER BY total_revenue_usd DESC;

-- ================================================================
-- END OF ANALYSIS
-- Dataset is synthetic and does not represent real market data.
-- =============================================================