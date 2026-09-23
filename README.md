# Big Tech's AI Spending: A Business Transformation Analysis

An end-to-end analysis of how five major technology companies have invested in AI infrastructure between 2018 and 2025, and whether that investment is converting into revenue growth and profitability — built from SEC 10-K filings through to an interactive business dashboard.

---

## Project Overview

This project investigates how five of the world's largest technology companies — NVIDIA, Microsoft, Google (Alphabet), Amazon, and Meta — have invested in AI infrastructure between 2018 and 2025, and whether that investment is translating into revenue growth and profitability. Using eight years of data drawn directly from each company's SEC Form 10-K filings, the project builds a complete, reproducible analytics workflow: from raw financial statements to a decision-ready business intelligence dashboard.

**Central question: Whose spending on R&D and infrastructure is converting into revenue growth and profit, and whose isn't?**

---

## Objectives

- Convert unstructured, multi-year annual report data into a single structured dataset
- Measure and compare growth, profitability, and investment intensity across companies on a consistent basis
- Identify how spending behavior shifted after the onset of the AI boom (2023 onward)
- Examine the relationship between the four largest AI infrastructure buyers and NVIDIA, the leading AI hardware supplier
- Communicate the findings through a structured, interactive business dashboard

---

## Toolkit and Function of Each Tool

| Tool | Function in this project |
|---|---|
| Excel | Data extraction, cleaning, standardization, and calculation of core financial ratios (growth, margins, spending intensity). Serves as the single source of truth for the dataset. |
| Python (Pandas, Matplotlib) | Exploratory data analysis. Used to identify growth patterns, compare spending intensity across companies and time, and visualize relationships between investment and performance before formal business questions were defined. |
| SQL (MySQL) | Structured business analysis. Used window functions, CTEs, and views to calculate year-over-year growth, rank companies, and answer specific, auditable business questions on the cleaned dataset. |
| Power BI | Data presentation and storytelling. A three-page interactive dashboard connects to the SQL data layer via DAX measures, allowing dynamic filtering by company and year. |

Each tool was chosen for the task it performs best: Excel for structured data entry and light calculation, Python for open-ended pattern discovery, SQL for precise and repeatable business queries, and Power BI for interactive presentation to a non-technical audience.

---

## Workflow
SEC 10-K Filings
↓
Excel — Extract → Clean → Structure → Calculate
↓
Python — Explore → Visualize → Identify patterns
↓
SQL — Query → Rank → Validate business questions
↓
Power BI — Model (DAX) → Visualize → Present
↓
Business Story

---

## Analytical Scope

Beyond the core growth-and-profitability comparison, three additional angles were incorporated to deepen the analysis:

- **Pre-AI vs. AI-boom comparison (2018-2022 vs. 2023-2025):** measuring how growth, margins, and spending shifted after the AI boom began
- **Capex relative to operating income:** identifying which companies are investing beyond their current earnings capacity
- **Buyers vs. supplier relationship:** comparing the combined capital expenditure of Microsoft, Google, Amazon, and Meta against NVIDIA's revenue, to examine the AI hardware supply chain as a single system

---

## Key Findings

**1. NVIDIA's growth vastly outpaced its own spending intensity**
NVIDIA achieved a 51.6% revenue CAGR (2018-2025), more than double any other company in the set, while its capital expenditure as a share of revenue declined — from 5.4% pre-AI-boom to 2.5% after.

**2. Microsoft's investment surge came without margin erosion**
Microsoft's capex intensity more than doubled after 2022 (12.0% → 26.2% of revenue), and its operating margin improved simultaneously (39.9% → 45.8%), indicating that increased investment has not come at the cost of profitability.

**3. Amazon is the standout outlier on reinvestment intensity**
Amazon is the only company in the dataset whose 2025 capital expenditure (US$131.8B) exceeded its operating income (US$80.0B), a 1.65x ratio — the highest reinvestment intensity in the group.

**4. The buyer-supplier relationship is structural, not tightly synchronized**
The combined capital expenditure of the four major buyers and NVIDIA's revenue move closely together at the level of totals (correlation of 0.98), though the relationship is considerably weaker year-to-year (0.21), indicating a structural link rather than a precisely timed one.

---

## Repository Structure
├── excel/
│ └── [your Excel filename here] # Cleaned, structured dataset with calculated ratios
├── python/
│ └── [your notebook/script filename here] # EDA, growth pattern analysis, visualizations
├── sql/
│ └── [your SQL filename here] # Window functions, CTEs, views, business queries
├── powerbi/
│ └── [your Power BI filename here] # 3-page interactive dashboard
└── README.md
---

## Analytical Limitations

With 40 observations across five companies, the analysis identifies patterns and associations, not causal relationships. Line-item definitions differ slightly by company (notably Amazon's broader "technology and infrastructure" classification versus a narrower R&D line elsewhere), and net income figures are affected by non-operating items such as investment gains and tax provisions, which is why operating margin was used as the primary profitability measure throughout.

---

## Skills Demonstrated

`Financial data extraction from SEC filings` · `Excel (data cleaning, structuring, formula-based calculation)` · `Python (Pandas, Matplotlib, exploratory data analysis)` · `SQL (window functions, CTEs, views)` · `Power BI (DAX, dashboard design)` · `End-to-end analytical workflow design`

---

## Notes

This project was built entirely from publicly available SEC Form 10-K filings. All figures are presented for analytical and educational purposes.

