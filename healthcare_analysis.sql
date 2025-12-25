-- Step 1: Data preview 
SELECT patient_id, age, gender, "condition", "procedure", "cost", length_of_stay, readmission, outcome, satisfaction
FROM analytics.patients;

-- Step 2: Executive KPI snapshot (overall performance)
SELECT
    COUNT(*) AS total_patients,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct,
    ROUND(AVG(satisfaction), 1) AS avg_satisfaction
FROM analytics.patients;


-- STEP 3: Condition-level performance to identify cost & risk drivers
SELECT
    condition,
    COUNT(*) AS patient_count,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct,
    ROUND(AVG(satisfaction), 1) AS avg_satisfaction
FROM analytics.patients
GROUP BY condition
HAVING COUNT(*) >= 20
ORDER BY avg_cost DESC;


-- STEP 4: Procedure performance for high-cost conditions
SELECT
    condition,
    procedure,
    COUNT(*) AS patient_count,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct,
    ROUND(AVG(satisfaction), 1) AS avg_satisfaction
FROM analytics.patients
WHERE condition IN ('Heart Attack', 'Heart Disease', 'Stroke')
GROUP BY condition, procedure
ORDER BY avg_cost DESC;


-- STEP 5: Risk stratification at patient level
SELECT
    patient_id,
    age,
    gender,
    condition,
    procedure,
    cost,
    length_of_stay,
    readmission,
    satisfaction,
    CASE
        WHEN readmission = 'Yes'
             OR cost >= 12000
             OR length_of_stay >= 40
        THEN 'High Risk'
        WHEN cost BETWEEN 6000 AND 11999
             OR length_of_stay BETWEEN 30 AND 39
        THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_group
FROM analytics.patients;


-- STEP 6: Aggregate impact by risk group
SELECT
    risk_group,
    COUNT(*) AS patient_count,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct,
    ROUND(AVG(satisfaction), 1) AS avg_satisfaction
FROM (
    SELECT
        *,
        CASE
            WHEN readmission = 'Yes'
                 OR cost >= 12000
                 OR length_of_stay >= 40
            THEN 'High Risk'
            WHEN cost BETWEEN 6000 AND 11999
                 OR length_of_stay BETWEEN 30 AND 39
            THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_group
    FROM analytics.patients
) t
GROUP BY risk_group
ORDER BY total_cost DESC;


-- STEP 7: Age cohort vs risk group analysis
SELECT
    age_group,
    risk_group,
    COUNT(*) AS patient_count,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct
FROM (
    SELECT
        *,
        CASE
            WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 49 THEN '30-49'
            WHEN age BETWEEN 50 AND 69 THEN '50-69'
            ELSE '70+'
        END AS age_group,
        CASE
            WHEN readmission = 'Yes'
                 OR cost >= 12000
                 OR length_of_stay >= 40
            THEN 'High Risk'
            WHEN cost BETWEEN 6000 AND 11999
                 OR length_of_stay BETWEEN 30 AND 39
            THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_group
    FROM analytics.patients
) t
GROUP BY age_group, risk_group
ORDER BY age_group, total_cost DESC;


-- STEP 8: Executive summary – top cost & risk drivers
SELECT
    age_group,
    condition,
    risk_group,
    COUNT(*) AS patient_count,
    ROUND(SUM(cost), 2) AS total_cost,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay,
    ROUND(
        100.0 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS readmission_rate_pct,
    ROUND(AVG(satisfaction), 1) AS avg_satisfaction
FROM (
    SELECT
        *,
        CASE
            WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 49 THEN '30-49'
            WHEN age BETWEEN 50 AND 69 THEN '50-69'
            ELSE '70+'
        END AS age_group,
        CASE
            WHEN readmission = 'Yes'
                 OR cost >= 12000
                 OR length_of_stay >= 40
            THEN 'High Risk'
            WHEN cost BETWEEN 6000 AND 11999
                 OR length_of_stay BETWEEN 30 AND 39
            THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_group
    FROM analytics.patients
) t
GROUP BY age_group, condition, risk_group
ORDER BY total_cost DESC
LIMIT 10;




