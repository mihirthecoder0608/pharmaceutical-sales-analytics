# 💊 Pharmaceutical Sales Performance & Market Analytics

An end-to-end data analytics project analyzing pharmaceutical sales performance using **MySQL, Power BI, and CSV data workflows**. The project focuses on revenue trends, sales target achievement, product performance, regional sales, distribution channels, and sales representative productivity.

> **Disclaimer:** This project uses a synthetic dataset for portfolio and educational purposes. The findings are illustrative and do not represent actual pharmaceutical market performance.

---

## 📌 Project Overview

Pharmaceutical businesses need to monitor sales performance, evaluate target achievement, identify high-performing products, and understand regional and channel-level trends.

This project uses SQL for data analysis and Power BI for interactive visualization to transform pharmaceutical sales records into actionable business insights.

### 🎯 Project Objectives

- Analyze overall revenue and sales target achievement.
- Track monthly and yearly sales trends.
- Compare sales performance across regions.
- Evaluate product and therapy-area performance.
- Analyze sales representative productivity.
- Compare distribution channel performance.
- Identify regions, products, and representatives below sales targets.
- Build an interactive dashboard to support data-driven decisions.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| MySQL 8.0+ | Data cleaning, validation, aggregation, and analysis |
| Power BI | Interactive dashboards and KPI visualization |
| SQL | Business analysis and performance measurement |
| CSV | Dataset storage and data import |
| Excel | Data inspection and supporting analysis |

---

## 📂 Repository Structure

```text
pharmaceutical-sales-analytics/
│
├── images/
│   ├── executive-overview.png
│   ├── product-analysis.png
│   └── sales-performance.png
│
├── .gitignore
├── Analytics_Dashboard.pbix
├── Pharmaceutical_Sales_Analytics_ppt.pptx
├── README.md
├── SQL_Scripts.sql
└── pharma_sales_analytics_dataset.csv
```

*The screenshot filenames above are examples. Replace them with your actual filenames after uploading screenshots to the `images/` folder.*

---

## 📊 Dataset Description

The dataset contains approximately **20,000 synthetic pharmaceutical sales records** covering 2024–2025.

### Key Features

| Column | Description |
|---|---|
| `Order_ID` | Order identifier |
| `Date` | Sales transaction date |
| `Region` | Geographical sales region |
| `Drug` | Pharmaceutical product |
| `Therapy_Area` | Therapeutic category |
| `Sales_Rep_ID` | Sales representative identifier |
| `Units_Sold` | Number of units sold |
| `Unit_Price_USD` | Unit selling price in USD |
| `Sales_Revenue_USD` | Recorded sales revenue in USD |
| `Sales_Target_USD` | Sales target in USD |
| `Channel` | Sales distribution channel |
| `Customer_Segment` | Customer segment classification |

**Dataset file:** `pharma_sales_analytics_dataset.csv`

---

## 📈 Power BI Dashboard

The interactive Power BI report consists of three analytical pages.

### 1. Executive Overview

Provides a high-level view of overall sales performance.

- Total Revenue
- Total Sales Target
- Target Achievement Percentage
- Revenue Variance
- Total Orders
- Monthly Revenue vs. Target
- Revenue by Region
- Interactive date, region, and drug filters

### 2. Product & Market Analysis

Evaluates product-level performance and revenue contribution.

- Revenue by Drug
- Revenue Contribution by Drug
- Target Achievement by Drug
- Units Sold by Drug
- Product Performance Table
- Region-wise Product Performance Matrix

### 3. Sales Force & Channel Performance

Analyzes sales representative productivity and distribution channels.

- Revenue by Sales Representative
- Revenue by Channel
- Units Sold by Channel
- Sales Representative Revenue vs. Target
- Target Achievement by Representative
- Sales Representative Performance Scorecard

  To see The dashboards Click here [DASHBOARD](https://app.powerbi.com/links/nMVNmfQT9q?ctid=edc5c3bf-4ab5-4697-84fa-41b44eb08b5e&pbi_source=linkShare)


---

## 🧮 Key Performance Indicators (KPIs)

| KPI | Calculation | Business Purpose |
|---|---|---|
| Total Revenue | Sum of `Sales_Revenue_USD` | Measures recorded sales value |
| Total Target | Sum of `Sales_Target_USD` | Measures assigned sales targets |
| Revenue Variance | Revenue − Target | Measures the monetary gap against target |
| Target Achievement % | Revenue ÷ Target × 100 | Measures target attainment |
| Total Units Sold | Sum of `Units_Sold` | Measures sales volume |
| Total Orders | Distinct count of `Order_ID` | Measures unique orders |
| Average Order Revenue | Revenue ÷ Total Orders | Measures average recorded revenue per order |
| Revenue Contribution % | Category revenue ÷ applicable total revenue × 100 | Measures contribution to revenue |

---

## 🗄️ SQL Analysis

**SQL file:** `SQL_Scripts.sql`

The MySQL analysis covers the following areas:

1. Dataset overview and key metrics
2. Data quality and missing-value checks
3. Duplicate order ID checks
4. Revenue calculation validation
5. Overall sales KPI analysis
6. Monthly revenue versus target
7. Yearly performance and year-over-year growth
8. Regional sales performance
9. Drug-wise revenue and target achievement
10. Therapy-area performance
11. Sales representative scorecard
12. Representatives performing below target
13. Channel-wise performance
14. Customer-segment performance
15. Region-wise drug performance
16. Months with below-target performance
17. Drug performance by channel
18. Top-performing sales representatives
19. Top and bottom representative comparisons
20. Executive-level summary
21. Category consistency checks
22. Data preparation for sales-versus-target analysis

### SQL Concepts Demonstrated

- Aggregate functions
- `GROUP BY` and `ORDER BY`
- Conditional logic
- Common Table Expressions (CTEs)
- Window functions such as `LAG()`
- Date-based analysis
- Data validation and consistency checks
- Business KPI calculations

---

## 💡 Key Business Insights

The following analytical areas help evaluate pharmaceutical sales performance. Populate specific rankings and numerical findings using the final SQL outputs and Power BI dashboard.

### 1. Overall Sales Performance

- Compare total revenue with the assigned sales target to evaluate overall target achievement.
- Analyze monthly and yearly trends to identify periods of growth or underperformance.
- Investigate revenue variance to understand where performance differs from expectations.

### 2. Regional Performance

- Compare revenue contribution and target achievement across all regions.
- Identify regions generating high revenue but still falling short of their targets.
- Investigate whether specific products, channels, or sales representatives contribute to regional performance gaps.

### 3. Product Performance

- Identify products contributing the largest share of total revenue.
- Compare product-level revenue with target achievement.
- Analyze units sold alongside revenue to understand differences in sales volume and recorded revenue.

### 4. Sales Representative Performance

- Rank sales representatives by revenue and target achievement.
- Identify representatives performing above or below their assigned targets.
- Compare representative performance to identify potential opportunities for coaching and resource allocation.

### 5. Distribution Channel Performance

- Compare revenue and units sold across distribution channels.
- Identify channels contributing the most to overall sales.
- Evaluate channel-level target achievement to identify areas requiring further investigation.

### 6. Revenue Trends and Target Gaps

- Use monthly revenue-versus-target analysis to identify periods of underperformance.
- Track year-over-year revenue changes to understand the direction of sales performance.
- Use revenue variance as an indicator of gaps requiring management attention.

---

## 🎯 Business Recommendations

### 1. Strengthen Regional Sales Planning

- Prioritize regions with consistently low target achievement for further investigation.
- Compare regional product mix, channel contribution, and representative performance before deciding on corrective action.
- Review whether regional targets align with historical performance and available sales opportunities.

### 2. Optimize Product-Level Decisions

- Monitor high-revenue products to understand their contribution to overall performance.
- Investigate products with low target achievement or declining sales trends.
- Evaluate product-level units sold and revenue together before making inventory or promotional decisions.

### 3. Improve Sales Representative Productivity

- Use regular performance scorecards to monitor revenue, target achievement, and sales volume.
- Identify high-performing representatives and study their sales practices for potentially transferable approaches.
- Provide targeted coaching and support to representatives who repeatedly fall below their assigned targets.

### 4. Evaluate Distribution Channels

- Compare revenue, sales volume, and target achievement across channels.
- Investigate underperforming channels at the product and regional levels.
- Allocate sales resources based on validated performance patterns rather than revenue alone.

### 5. Establish Regular KPI Reviews

- Review revenue, target achievement, and revenue variance monthly.
- Use dashboard filters to drill down into regions, products, channels, and sales representatives.
- Investigate significant deviations from targets early and document follow-up actions.

### 6. Improve Future Analytics

- Incorporate cost and gross-margin data to measure profitability.
- Add inventory and demand data to support stock planning.
- Integrate external market data to evaluate market share and competitive performance.
- Introduce forecasting to estimate future revenue and identify potential target gaps.

---

## 📌 Expected Business Value

This project demonstrates how SQL analysis and interactive Power BI dashboards can help stakeholders:

- Monitor sales performance against targets.
- Identify regional and product-level performance gaps.
- Compare sales representative productivity.
- Understand channel contribution to revenue.
- Support evidence-based sales planning and resource allocation.
- Establish a repeatable framework for performance monitoring.

*These are potential business benefits, not measured financial outcomes. Actual impact would need to be evaluated using real operational data and subsequent business results.*

---

## 🔄 Project Workflow

1. **Data Import:** Load the CSV dataset into MySQL and Power BI.
2. **Data Validation:** Check missing values, duplicate identifiers, data types, and revenue consistency.
3. **SQL Analysis:** Calculate KPIs and analyze sales performance across products, regions, channels, and representatives.
4. **Dashboard Development:** Create measures, charts, tables, slicers, and interactive report pages in Power BI.
5. **Performance Interpretation:** Compare revenue against targets and identify areas for further investigation.
6. **Presentation:** Summarize the analytical approach and findings in the PowerPoint presentation.

---

## 🚀 How to Run the Project

### Step 1: Clone the Repository

```bash
git clone <your-github-repository-url>
```

Alternatively, download the repository as a ZIP file from GitHub.

### Step 2: Create the MySQL Database

```sql
CREATE DATABASE pharma_analytics;
USE pharma_analytics;
```

Import `pharma_sales_analytics_dataset.csv` into a table named:

```sql
pharma_sales_analytics_dataset
```

Ensure the table columns and data types match those referenced in `SQL_Scripts.sql`.

### Step 3: Execute the SQL Queries

Open `SQL_Scripts.sql` in MySQL Workbench, confirm the database and table names, and execute the queries to review the analysis results.

### Step 4: Open the Power BI Dashboard

Open `Analytics_Dashboard.pbix` in Microsoft Power BI Desktop.

If necessary, update the data source settings and reconnect the report to your local dataset or database.

### Step 5: Review the Presentation

Open `Pharmaceutical_Sales_Analytics_ppt.pptx` to review the project objectives, analytical approach, dashboard, findings, and recommendations.

---

## ⚠️ Limitations

- The dataset is synthetic and should not be interpreted as real pharmaceutical sales data.
- The analysis describes patterns in the available fields; it does not establish causal relationships.
- Profitability cannot be calculated reliably without cost and margin data.
- Market share cannot be calculated without external market-size and competitor data.
- Findings depend on the accuracy and consistency of the dataset and analysis logic.

---

## 🔮 Future Improvements

- Add profit, cost, and gross-margin analysis.
- Integrate real or appropriately licensed pharmaceutical sales data.
- Add forecasting for revenue and demand.
- Implement automated data refresh and scheduled reporting.
- Introduce customer retention and purchasing-frequency analysis where suitable data is available.
- Add drill-through pages and advanced time-intelligence measures.
- Improve data modeling with a dedicated date table and documented business rules.

---

## 📚 Skills Demonstrated

- SQL and MySQL
- Data cleaning and validation
- Exploratory data analysis
- KPI development
- Business performance analysis
- Power BI dashboard development
- Data visualization
- Analytical storytelling
- Business recommendations

---

## 👨‍💻 Author

**Mihir Mishra**

Electrical Engineering Undergraduate | Aspiring Data Analyst

**Areas of Interest:** Data Analytics, Business Intelligence, SQL, Power BI, Python, and Data-Driven Decision Making.

[Linkedin](https://www.linkedin.com/in/mihirmishra74638ghy) 
[Email](mihirmishra006@gmail.com)

---

⭐ If you find this project useful, feel free to explore the repository and share feedback.

