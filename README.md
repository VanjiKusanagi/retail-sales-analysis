# Retail Sales Analysis

An end-to-end retail sales analysis that turns a Kaggle sample dataset into a cleaned analysis-ready file, a SQLite database, and business-focused insights. The goal is to understand what drives revenue, how sales change over time, and how purchasing patterns differ across products and customer groups.

## Project Overview

The repository was created through these steps:

1. Downloaded the source dataset from [Kaggle: Retail Sales Dataset](https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset?resource=download).
2. Explored, validated, cleaned, and analyzed the data in `Retail Data Analysis.ipynb` using Python and Jupyter.
3. Exported the prepared data to `retail_sales_clean.csv`, including date, age-group, and price-tier features.
4. Imported the cleaned CSV into SQLite using DB Browser for SQLite and saved the database as `retail_sales.db`.
5. Wrote reusable analysis queries in `retail_sales_queries.sql`.

## Dataset

The source file is [`retail_sales_dataset.csv`](retail_sales_dataset.csv), downloaded from the Kaggle link above. It contains 1,000 transactions and 9 columns:

| Column | Description |
| --- | --- |
| `Transaction ID` | Transaction identifier |
| `Date` | Transaction date |
| `Customer ID` | Customer identifier |
| `Gender` | Customer gender as recorded in the source data |
| `Age` | Customer age |
| `Product Category` | Product category |
| `Quantity` | Units purchased |
| `Price per Unit` | Unit price |
| `Total Amount` | Transaction amount |

The cleaned export contains 16 columns. It uses normalized column names and adds calendar fields (`year_month`, `quarter`, `month_num`, `month_name`, `day_of_week`), `age_group`, and `price_tier`.

## Tools

- Python: pandas, NumPy, matplotlib, seaborn
- Jupyter Notebook for data validation, cleaning, analysis, and visualizations
- SQL with SQLite; database created and managed in DB Browser for SQLite
- Power BI is planned; the `.pbix` file will be added later

## Business Questions

1. How did revenue change by month and quarter, and which periods performed best and worst?
2. Which product categories and price tiers contribute most to revenue, transaction volume, and average order value?
3. How do revenue and average order value vary by customer age group and gender, and what categories do those groups buy?
4. How concentrated is revenue among transactions, and how does sales activity vary by day of the week?

## Key Findings

- The sample records **$456,000** in revenue from **1,000 transactions**, with **2,514 units** sold and an average transaction value of **$456.00**.
- Premium-priced items (unit price $300+) account for **39.6% of transactions** but **88.36% of revenue** ($402,900).
- Electronics lead category revenue at **$156,905 (34.41%)**, narrowly ahead of Clothing at **$155,580 (34.12%)**; Beauty contributes **$143,515 (31.47%)**.
- In the 2023 monthly trend, **May** is the strongest month at **$53,150**, while **September** is the weakest at **$23,620**. The notebook excludes January 2024 from monthly trend analysis because it contains only a partial month.
- The largest **20% of transactions generate 62.5% of revenue**; the largest 10% generate 38.2%.

## Repository Contents

```text
.
├── Retail Data Analysis.ipynb   # Python exploration, cleaning, charts, and export
├── retail_sales_dataset.csv     # Original Kaggle dataset (1,000 rows, 9 columns)
├── retail_sales_clean.csv       # Cleaned dataset with derived analysis fields
├── retail_sales.db              # SQLite database built from the cleaned dataset
├── retail_sales_queries.sql     # KPI, category, trend, tier, and customer queries
├── screenshots/                 # Dashboard screenshots will be added later
└── README.md
```

The Power BI `.pbix` file is also planned and will be added later. Screenshots, including the dashboard screenshot, are not available yet and will be added later.

## Run the Analysis

### Python notebook

1. Clone or download this repository and open it as a folder in VS Code or Jupyter.
2. Install the notebook dependencies:

   ```bash
   python -m pip install pandas numpy matplotlib seaborn jupyter
   ```

3. Open `Retail Data Analysis.ipynb` and run the cells from top to bottom. Keep `retail_sales_dataset.csv` in the same folder as the notebook; the export cell writes `retail_sales_clean.csv` there.

### SQLite queries

1. Open `retail_sales.db` in DB Browser for SQLite.
2. Confirm the cleaned data is available in a table named `retail_sales` (the queries expect that table and the columns in `retail_sales_clean.csv`).
3. Open `retail_sales_queries.sql` in the Execute SQL tab and run the queries.

The SQL file includes headline KPIs, category revenue and share, monthly growth, cumulative revenue, top category by month, price-tier mix, age-group spending, and category revenue by gender.

## Limitations and Next Steps

- This is a 1,000-transaction sample, so its findings should not be treated as representative of a full retailer or market.
- The sample has 1,000 unique customer IDs across 1,000 transactions, so repeat-purchase and customer-retention behavior cannot be assessed from these records.
- Monthly trend analysis excludes January 2024 because the notebook identifies it as partial-period data.
- The price-tier split is based on the source's observed price points ($25, $30, $50, $300, and $500); the labels are project-specific rather than an independently validated business definition.
- Add the Power BI report and dashboard screenshots when available, then update this README with the report view and any additional findings.

## Repository Visibility

For portfolio or recruiting use, set the repository visibility to **Public** in the hosting platform's repository settings. Visibility is controlled by the repository host and is not changed by this README.