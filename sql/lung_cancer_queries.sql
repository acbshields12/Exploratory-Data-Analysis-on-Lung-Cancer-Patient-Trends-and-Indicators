-- ============================================================
--   LUNG CANCER DATASET — SQL QUERIES
--   Author  : Clark
--   Dataset : 1,500 Patients | 2015-2025
--   Engine  : MySQL / PostgreSQL / SQL Server compatible
-- ============================================================


-- ============================================================
-- STEP 0: CREATE TABLE
-- (Skip this if you are importing the CSV directly)
-- ============================================================
CREATE DATABASE lung_cancer_analysis;
USE lung_cancer_analysis;

CREATE TABLE lung_cancer (
    Patient_ID              VARCHAR(20),
    Diagnosis_Year          INT,
    Diagnosis_Date          DATE,
    WHO_Region              VARCHAR(50),
    Country                 VARCHAR(50),
    Age                     INT,
    Gender                  VARCHAR(10),
    Smoking_Status          VARCHAR(30),
    Cigarettes_Per_Day      INT,
    Years_Smoking           INT,
    Secondhand_Smoke        VARCHAR(5),
    Family_History          VARCHAR(5),
    Occupational_Hazard     VARCHAR(5),
    Air_Pollution_Exposure  VARCHAR(20),
    Alcohol_Use             VARCHAR(20),
    BMI                     DECIMAL(5,2),
    Exercise_Frequency      VARCHAR(20),
    Chronic_Lung_Disease    VARCHAR(5),
    Asbestos_Exposure       VARCHAR(5),
    Radon_Exposure          VARCHAR(5),
    Previous_Cancer_History VARCHAR(5),
    Genetic_Mutation        VARCHAR(30),
    Coughing                VARCHAR(5),
    Shortness_of_Breath     VARCHAR(5),
    Chest_Pain              VARCHAR(5),
    Coughing_Blood          VARCHAR(5),
    Fatigue                 VARCHAR(5),
    Weight_Loss             VARCHAR(5),
    Wheezing                VARCHAR(5),
    Recurrent_Infections    VARCHAR(5),
    Swallowing_Difficulty   VARCHAR(5),
    Finger_Clubbing         VARCHAR(5),
    Cancer_Type             VARCHAR(20),
    NSCLC_Subtype           VARCHAR(30),
    Cancer_Stage            VARCHAR(20),
    Tumor_Size_cm           DECIMAL(5,2),
    Metastasis              VARCHAR(5),
    Diagnosis_Method        VARCHAR(30),
    Treatment               VARCHAR(50),
    Survival_Months         INT,
    Survived                VARCHAR(5)
);


-- ============================================================
-- SECTION 1: DATA EXPLORATION
-- ============================================================

-- Q1.1: Preview first 10 rows
SELECT * FROM lung_cancer LIMIT 10;

-- Q1.2: Total patient count
SELECT COUNT(*) AS total_patients FROM lung_cancer;

-- Q1.3: Check for NULL values in key columns
SELECT
    SUM(CASE WHEN Age          IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN Gender       IS NULL THEN 1 ELSE 0 END) AS missing_gender,
    SUM(CASE WHEN Cancer_Stage IS NULL THEN 1 ELSE 0 END) AS missing_stage,
    SUM(CASE WHEN Treatment    IS NULL THEN 1 ELSE 0 END) AS missing_treatment,
    SUM(CASE WHEN Survived     IS NULL THEN 1 ELSE 0 END) AS missing_survived
FROM lung_cancer;

-- Q1.4: List distinct cancer stages
SELECT DISTINCT Cancer_Stage FROM lung_cancer ORDER BY Cancer_Stage;


-- ============================================================
-- SECTION 2: PATIENT DEMOGRAPHICS
-- ============================================================

-- Q2.1: Count by gender with percentage
SELECT
    Gender,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_total
FROM lung_cancer
GROUP BY Gender
ORDER BY total_patients DESC;

-- Q2.2: Average, min, max age by stage
SELECT
    Cancer_Stage,
    ROUND(AVG(Age), 1) AS avg_age,
    MIN(Age)           AS youngest,
    MAX(Age)           AS oldest,
    COUNT(*)           AS patient_count
FROM lung_cancer
GROUP BY Cancer_Stage
ORDER BY Cancer_Stage;

-- Q2.3: Patient count by WHO Region
SELECT
    WHO_Region,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_total
FROM lung_cancer
GROUP BY WHO_Region
ORDER BY total_patients DESC;

-- Q2.4: Age group distribution (histogram-style)
SELECT
    CASE
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END AS age_group,
    COUNT(*) AS patient_count
FROM lung_cancer
GROUP BY age_group
ORDER BY age_group;


-- ============================================================
-- SECTION 3: RISK FACTORS
-- ============================================================

-- Q3.1: Smoking status breakdown
SELECT
    Smoking_Status,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM lung_cancer
GROUP BY Smoking_Status
ORDER BY total DESC;

-- Q3.2: Avg cigarettes per day and years smoking by stage (current smokers only)
SELECT
    Cancer_Stage,
    ROUND(AVG(Cigarettes_Per_Day), 1) AS avg_cigarettes_per_day,
    ROUND(AVG(Years_Smoking), 1)      AS avg_years_smoking
FROM lung_cancer
WHERE Smoking_Status = 'Current Smoker'
GROUP BY Cancer_Stage
ORDER BY Cancer_Stage;

-- Q3.3: Risk factor count per patient (how many risk factors each person has)
SELECT
    Patient_ID,
    Cancer_Stage,
    (CASE WHEN Smoking_Status != 'Never Smoked'  THEN 1 ELSE 0 END
   + CASE WHEN Secondhand_Smoke = 'Yes'          THEN 1 ELSE 0 END
   + CASE WHEN Family_History = 'Yes'            THEN 1 ELSE 0 END
   + CASE WHEN Occupational_Hazard = 'Yes'       THEN 1 ELSE 0 END
   + CASE WHEN Air_Pollution_Exposure != 'Low'   THEN 1 ELSE 0 END
   + CASE WHEN Chronic_Lung_Disease = 'Yes'      THEN 1 ELSE 0 END
   + CASE WHEN Asbestos_Exposure = 'Yes'         THEN 1 ELSE 0 END
   + CASE WHEN Radon_Exposure = 'Yes'            THEN 1 ELSE 0 END
    ) AS risk_factor_count
FROM lung_cancer
ORDER BY risk_factor_count DESC
LIMIT 20;

-- Q3.4: Never-smokers diagnosed at Stage III or IV (surprising finding)
SELECT
    Cancer_Stage,
    Secondhand_Smoke,
    Air_Pollution_Exposure,
    Genetic_Mutation,
    COUNT(*) AS patient_count
FROM lung_cancer
WHERE Smoking_Status = 'Never Smoked'
  AND Cancer_Stage IN ('Stage III', 'Stage IV')
GROUP BY Cancer_Stage, Secondhand_Smoke, Air_Pollution_Exposure, Genetic_Mutation
ORDER BY patient_count DESC;


-- ============================================================
-- SECTION 4: CANCER STAGE AND TUMOR ANALYSIS
-- ============================================================

-- Q4.1: Patient count and tumor size stats by stage
SELECT
    Cancer_Stage,
    COUNT(*)                         AS patient_count,
    ROUND(AVG(Tumor_Size_cm), 2)     AS avg_tumor_size_cm,
    ROUND(MIN(Tumor_Size_cm), 2)     AS min_tumor_size_cm,
    ROUND(MAX(Tumor_Size_cm), 2)     AS max_tumor_size_cm,
    SUM(CASE WHEN Metastasis = 'Yes' THEN 1 ELSE 0 END) AS with_metastasis
FROM lung_cancer
GROUP BY Cancer_Stage
ORDER BY Cancer_Stage;

-- Q4.2: NSCLC subtype distribution
SELECT
    NSCLC_Subtype,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM lung_cancer
WHERE Cancer_Type = 'NSCLC'
GROUP BY NSCLC_Subtype
ORDER BY count DESC;

-- Q4.3: Diagnosis method by stage
SELECT
    Cancer_Stage,
    Diagnosis_Method,
    COUNT(*) AS diagnosed_count
FROM lung_cancer
GROUP BY Cancer_Stage, Diagnosis_Method
ORDER BY Cancer_Stage, diagnosed_count DESC;


-- ============================================================
-- SECTION 5: SURVIVAL ANALYSIS  (KEY QUERIES)
-- ============================================================

-- Q5.1: Overall survival rate
SELECT
    COUNT(*) AS total_patients,
    SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END) AS survived,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS survival_rate_pct
FROM lung_cancer;

-- Q5.2: Survival rate by stage
SELECT
    Cancer_Stage,
    COUNT(*) AS total,
    SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END) AS survived,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS survival_rate_pct,
    ROUND(AVG(Survival_Months), 1) AS avg_survival_months
FROM lung_cancer
GROUP BY Cancer_Stage
ORDER BY Cancer_Stage;

-- Q5.3: Survival rate by treatment type
SELECT
    Treatment,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END) AS survived,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS survival_rate_pct,
    ROUND(AVG(Survival_Months), 1) AS avg_survival_months
FROM lung_cancer
GROUP BY Treatment
ORDER BY avg_survival_months DESC;

-- Q5.4: Survival rate by gender
SELECT
    Gender,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS survival_rate_pct,
    ROUND(AVG(Survival_Months), 1) AS avg_survival_months
FROM lung_cancer
GROUP BY Gender
ORDER BY survival_rate_pct DESC;

-- Q5.5: Top 10 longest-surviving patients
SELECT
    Patient_ID, Age, Gender, Cancer_Stage,
    Treatment, Survival_Months, Survived
FROM lung_cancer
ORDER BY Survival_Months DESC
LIMIT 10;


-- ============================================================
-- SECTION 6: WINDOW FUNCTIONS (Advanced)
-- ============================================================

-- Q6.1: Rank treatments by survival rate WITHIN each stage
-- PARTITION BY = "reset the ranking for each stage"
SELECT
    Cancer_Stage,
    Treatment,
    total_patients,
    survival_rate_pct,
    RANK() OVER (
        PARTITION BY Cancer_Stage
        ORDER BY survival_rate_pct DESC
    ) AS rank_within_stage
FROM (
    SELECT
        Cancer_Stage,
        Treatment,
        COUNT(*) AS total_patients,
        ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
              * 100.0 / COUNT(*), 1) AS survival_rate_pct
    FROM lung_cancer
    GROUP BY Cancer_Stage, Treatment
) subquery
ORDER BY Cancer_Stage, rank_within_stage;

-- Q6.2: Rolling 3-year average of new diagnoses
SELECT
    Diagnosis_Year,
    COUNT(*) AS new_diagnoses,
    ROUND(AVG(COUNT(*)) OVER (
        ORDER BY Diagnosis_Year
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 0) AS rolling_3yr_avg
FROM lung_cancer
GROUP BY Diagnosis_Year
ORDER BY Diagnosis_Year;

-- Q6.3: Cumulative patient count over the years
SELECT
    Diagnosis_Year,
    COUNT(*) AS yearly_count,
    SUM(COUNT(*)) OVER (ORDER BY Diagnosis_Year) AS cumulative_patients
FROM lung_cancer
GROUP BY Diagnosis_Year
ORDER BY Diagnosis_Year;

-- Q6.4: Tumor size percentile rank per patient
SELECT
    Patient_ID,
    Cancer_Stage,
    Tumor_Size_cm,
    ROUND(PERCENT_RANK() OVER (ORDER BY Tumor_Size_cm) * 100, 1) AS size_percentile
FROM lung_cancer
ORDER BY Tumor_Size_cm DESC
LIMIT 20;


-- ============================================================
-- SECTION 7: SUBQUERIES
-- ============================================================

-- Q7.1: Patients with above-average tumor size
SELECT
    Patient_ID, Cancer_Stage, Tumor_Size_cm, Treatment, Survived
FROM lung_cancer
WHERE Tumor_Size_cm > (SELECT AVG(Tumor_Size_cm) FROM lung_cancer)
ORDER BY Tumor_Size_cm DESC;

-- Q7.2: Stages where survival rate is above the overall average
SELECT
    Cancer_Stage,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS stage_survival_rate
FROM lung_cancer
GROUP BY Cancer_Stage
HAVING ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
             * 100.0 / COUNT(*), 1)
       > (
           SELECT ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
                        * 100.0 / COUNT(*), 1)
           FROM lung_cancer
       );


-- ============================================================
-- SECTION 8: VIEW (Reusable summary for Power BI / reports)
-- ============================================================

CREATE OR REPLACE VIEW vw_lung_cancer_summary AS
SELECT
    Cancer_Stage,
    Treatment,
    Gender,
    Smoking_Status,
    WHO_Region,
    COUNT(*) AS patient_count,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Tumor_Size_cm), 2) AS avg_tumor_size,
    ROUND(AVG(Survival_Months), 1) AS avg_survival_months,
    ROUND(SUM(CASE WHEN Survived = 'Yes' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1) AS survival_rate_pct
FROM lung_cancer
GROUP BY Cancer_Stage, Treatment, Gender, Smoking_Status, WHO_Region;

-- Query the view
SELECT * FROM vw_lung_cancer_summary ORDER BY survival_rate_pct DESC;

-- ============================================================
-- END OF FILE
-- ============================================================
