-- ============================================================
-- Telecom Customer Churn Analysis — SQL Queries
-- Tool used: DB Browser for SQLite
-- Dataset: telco_churn_cleaned (cleaned in Python/Pandas beforehand)
-- Main question: Why are customers leaving this telecom provider,
-- and what should the company do about it?
-- ============================================================


-- ============================================================
-- Sub-question 1: Does churn rate differ by contract type?
-- ============================================================

-- Raw counts of customers by contract type and churn status
SELECT Contract, Churn, COUNT(*) AS customer_count
FROM telco_churn_cleaned
GROUP BY Contract, Churn;

-- Churn rate (%) by contract type
SELECT
    Contract,
    ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate_pct
FROM telco_churn_cleaned
GROUP BY Contract;

-- Finding: The longer the contract, the lower the churn rate.
-- Month-to-month: 42.71% | One year: 11.27% | Two year: 2.83%


-- ============================================================
-- Sub-question 2: Does churn rate differ by tenure
-- (new vs. long-term customers)?
-- ============================================================

-- Average tenure (in months) for churned vs. retained customers
SELECT Churn, AVG(tenure) AS avg_tenure
FROM telco_churn_cleaned
GROUP BY Churn;

-- Finding: Customers who stayed average 37.6 months of tenure;
-- customers who churned average only 17.9 months.
-- Newer customers churn far more than long-term customers.


-- ============================================================
-- Sub-question 3: Do add-on services (tech support, streaming)
-- correlate with lower churn?
-- ============================================================

-- Tech Support: raw counts by churn status
SELECT TechSupport, Churn, COUNT(*) AS customer_count
FROM telco_churn_cleaned
GROUP BY TechSupport, Churn;

-- Tech Support: churn rate (%)
SELECT
    TechSupport,
    ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate_pct
FROM telco_churn_cleaned
GROUP BY TechSupport;

-- Finding: Customers WITHOUT tech support churn far more (41.64%)
-- than those WITH tech support (15.17%). Customers with no internet
-- service at all churn least (7.4%), since they have fewer things
-- to be dissatisfied with in the first place.

-- Streaming TV: churn rate (%)
SELECT
    StreamingTV,
    ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate_pct
FROM telco_churn_cleaned
GROUP BY StreamingTV;

-- Finding: StreamingTV shows a much smaller gap: No (33.52%) vs.
-- Yes (30.07%) vs. No internet service (7.4%).

-- Streaming Movies: churn rate (%)
SELECT
    StreamingMovies,
    ROUND(100.0 * AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate_pct
FROM telco_churn_cleaned
GROUP BY StreamingMovies;

-- Finding: Same pattern as StreamingTV: No (33.68%) vs.
-- Yes (29.94%) vs. No internet service (7.4%).
-- Takeaway: Tech support has the strongest relationship with churn
-- out of the three add-ons tested. Streaming services show only a
-- small effect on churn by comparison.


-- ============================================================
-- Sub-question 4: Is there a pricing/charges pattern among
-- customers who churn?
-- ============================================================

-- Average monthly charges for churned vs. retained customers
SELECT
    Churn,
    AVG(MonthlyCharges) AS avg_monthly_charges
FROM telco_churn_cleaned
GROUP BY Churn;

-- Finding: Customers who churn pay slightly more on average
-- ($74.44/month) than customers who stay ($61.27/month).
-- The gap exists but is fairly modest, not a dramatic difference.


-- ============================================================
-- Notes
-- ============================================================
-- Tools used: Python (Pandas, in Google Colab) for cleaning,
-- SQLite (DB Browser) for querying, Power BI for the dashboard.
--
-- Cleaning note: 11 rows were dropped after converting
-- TotalCharges to numeric (df['TotalCharges'] = pd.to_numeric(
-- df['TotalCharges'], errors='coerce')) and removing rows with
-- missing values (df = df.dropna()).
--
-- Overall takeaways:
-- 1. The longer the contract, the less churn.
-- 2. More monthly charges -> somewhat more churn.
-- 3. Lack of tech support is strongly associated with churn.
