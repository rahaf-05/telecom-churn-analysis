# Telecom Customer Churn Analysis

**Business question:** Why are customers leaving this telecom provider, and what should the company do about it?

**Tools used:** Python (Pandas, via Google Colab) for data cleaning and exploration, SQL (DB Browser for SQLite) for query-based analysis, and Power BI for the interactive dashboard.

## Dashboard

![Churn Dashboard](./dashboard/screenshots/dashboard_overview.png)

## Top Findings

- **Contract length is the strongest driver of churn** — month-to-month customers churn at 42.71%, compared to just 2.83% for two-year contracts, a roughly 15x difference.
- **Newer customers are at highest risk** — churned customers average 17.9 months of tenure vs. 37.5 months for retained customers.
- **Lack of technical support nearly triples churn risk** — 41.6% churn without it vs. 15.1% with it, a stronger effect than streaming add-ons.
- **Pricing plays a smaller role** — churned customers pay modestly more on average ($74.44 vs. $61.27/month).

## Project Structure

- [`notebook/`](./notebook/) — data cleaning and exploration in Python/Pandas
- [`sql-analysis/`](./sql-analysis/query_results.md) — full SQL queries, results, and screenshots for each sub-question
- [`dashboard/`](./dashboard/) — Power BI dashboard file (`.pbix`) and PDF export
- [`executive_summary.pdf`](./executive_summary.pdf) — one-page business summary with recommendations and impact estimate

## Methodology

Data cleaned by converting `TotalCharges` to numeric and dropping resulting missing rows (11 rows removed). Findings validated with SQL and visualized in Power BI. Dataset: [IBM Telco Customer Churn](https://www.kaggle.com) (Kaggle).

