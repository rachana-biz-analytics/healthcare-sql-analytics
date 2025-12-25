# Healthcare SQL Analytics Project

Advanced SQL analytics on healthcare patient data to analyze cost, length of stay (LOS), readmissions, risk, and patient outcomes.

---

## Project Objective
Use SQL to identify:
- High-cost medical conditions and procedures  
- Drivers of long length of stay (LOS)  
- Patient groups with high readmission risk  
- Opportunities to improve outcomes and satisfaction  

This simulates real-world hospital and payer analytics used for cost control and quality improvement.

---

## Dataset

**Source:**  
CDC Social Vulnerability Index (SVI) – Data.gov  
https://catalog.data.gov/dataset/cdc-social-vulnerability-index-cdcsvi  

**File used in this project:**  
`data/svi_cleaned_data.csv`

> Note: The original CDC SVI dataset was cleaned and transformed to create a healthcare-style patient dataset with fields such as age, condition, procedure, cost, length_of_stay, readmission, outcome, and satisfaction for analysis practice.

---

## Data Preparation
- Removed null and duplicate records  
- Selected relevant columns for patient analytics  
- Renamed fields for SQL friendliness  
- Created derived fields such as:
  - Risk groups (High / Medium / Low)
  - Age cohorts (Under 30, 30–49, 50–69, 70+)  

Cleaned file is stored in: `data/svi_cleaned_data.csv`

---

## SQL Analysis Workflow

All queries are available in:  
`healthcare_analysis.sql`

The analysis includes:

1. Data preview & structure check  
2. Executive KPI snapshot (volume, cost, LOS, readmissions, satisfaction)  
3. Condition-level cost & risk drivers  
4. Procedure analysis for high-cost conditions  
5. Patient risk stratification  
6. Aggregate impact by risk group  
7. Age cohort vs risk analysis  
8. Executive summary of top cost & risk drivers  

---

## Skills Demonstrated
- Advanced SQL (GROUP BY, HAVING, CASE, subqueries)  
- KPI development & healthcare metrics  
- Risk stratification logic  
- Cohort & segmentation analysis  
- Business-focused storytelling with data  

---

## Repository Structure
---

## How to Run This Project

1. Load the cleaned dataset:
   - File: `data/svi_cleaned_data.csv`
2. Create a table in PostgreSQL (or any SQL DB) similar to:
   - `analytics.patients`
3. Import the CSV into the table.
4. Open and execute queries in:
   - `healthcare_analysis.sql`
5. Run queries step-by-step from top to bottom to reproduce the analysis.

This project was developed and tested using PostgreSQL and DBeaver.

---

## Key Business Insights

From this analysis, we can:
- Identify medical conditions driving the highest cost and LOS.
- Detect patient groups with elevated readmission risk.
- Highlight high-risk cohorts contributing most to total cost.
- Support hospital leaders in targeting:
  - Care pathway optimization  
  - Readmission reduction programs  
  - Cost containment strategies  

These insights align with real-world healthcare KPIs used by payers and providers.

---

## Why This Project Matters

This project demonstrates how SQL can be used not just for querying data, but for:
- Executive-level KPI reporting  
- Risk stratification  
- Cohort analysis  
- Translating data into operational decisions  

It reflects industry-style analytics expected from a Business/Data Analyst in healthcare.

---


