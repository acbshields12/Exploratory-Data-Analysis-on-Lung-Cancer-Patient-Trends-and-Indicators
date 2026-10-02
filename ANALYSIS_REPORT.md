# LUNG CANCER ANALYSIS REPORT
## Prepared by: Clark | April 2026

---

## EXECUTIVE SUMMARY

This report presents a data analysis of **1,500 lung cancer patients** diagnosed between **2015 and 2025** across multiple WHO regions. The dataset includes patient demographics, risk factors, cancer staging, treatment types, and survival outcomes.

**Three headline findings:**

1. **Early detection is the single biggest driver of survival** — Stage I patients survive at nearly 4x the rate of Stage IV patients.
2. **Surgery yields the best outcomes**, with the highest average survival months of any treatment.
3. **Smoking alone does not explain the full picture** — 65% of patients never smoked, pointing to secondhand smoke, pollution, and genetic mutations as significant contributors.

---

## 1. DATASET OVERVIEW

| Metric | Value |
|--------|-------|
| Total Patients | 1,500 |
| Time Period | 2015–2025 |
| Countries Covered | 15+ |
| WHO Regions | 6 |
| Columns / Variables | 41 |
| Average Age | 60.7 years |
| Overall Survival Rate | 36.9% |
| Average Survival (months) | 31.2 months |
| Average Tumor Size | 4.6 cm |

---

## 2. PATIENT DEMOGRAPHICS

### Age
- Patients range from **30 to 89 years old**
- The median age is **60 years**
- The 60–69 age group is the largest segment

### Gender
| Gender | Count | % |
|--------|-------|---|
| Male | 934 | 62.3% |
| Female | 566 | 37.7% |

Males represent nearly **2 in 3 patients**, consistent with global patterns tied to higher smoking prevalence and occupational hazard exposure among men.

### WHO Region
| Region | Patients | % |
|--------|----------|---|
| Western Pacific | ~400 | ~27% |
| Americas | ~300 | ~20% |
| Europe | ~280 | ~19% |
| South-East Asia | ~250 | ~17% |
| Eastern Mediterranean | ~150 | ~10% |
| Africa | ~120 | ~8% |

The **Western Pacific region** (China, Japan, Singapore, Philippines) carries the largest burden, driven by high smoking rates and severe air pollution in major cities.

---

## 3. RISK FACTOR ANALYSIS

### Smoking Status
| Status | Count | % |
|--------|-------|---|
| Never Smoked | 979 | 65.3% |
| Current Smoker | 364 | 24.3% |
| Former Smoker | 157 | 10.5% |

> **Insight:** The majority of patients (65%) never smoked. This is a critical finding. It means smoking is not the only — or even the primary — driver in this dataset. Other factors like **secondhand smoke exposure, high air pollution, genetic mutations (KRAS, EGFR), and occupational hazards** are likely contributing significantly.

### Other Risk Factors Observed
- **Secondhand Smoke:** Present in a significant portion of never-smokers
- **Air Pollution Exposure:** High in Western Pacific patients
- **Genetic Mutations:** KRAS and EGFR mutations observed across all stages
- **Chronic Lung Disease:** Elevates risk of misdiagnosis delays
- **Occupational Hazard (asbestos, chemicals):** More common in male patients

---

## 4. CANCER STAGING

| Stage | Patients | % |
|-------|----------|---|
| Stage I | 436 | 29.1% |
| Stage II | 356 | 23.7% |
| Stage III | 351 | 23.4% |
| Stage IV | 357 | 23.8% |

The distribution is relatively even across stages, which is unusual in real-world settings (Stage IV typically dominates). This suggests the dataset includes patients from both early screening programs and late-presentation cases.

**Average Tumor Size by Stage:**
- Stage I: ~2.5 cm
- Stage II: ~3.8 cm
- Stage III: ~5.5 cm
- Stage IV: ~7.2 cm

Tumor size increases predictably with stage — a useful validation that the data is internally consistent.

---

## 5. TREATMENT ANALYSIS

| Treatment | Patients | Avg Survival (months) |
|-----------|----------|----------------------|
| Surgery | 310 | Highest |
| Surgery + Chemotherapy | 223 | High |
| Immunotherapy | 216 | Moderate-High |
| Targeted Therapy | 167 | Moderate |
| Chemotherapy | 253 | Moderate |
| Radiotherapy | 160 | Moderate |
| Chemo + Radiation | 134 | Moderate |
| Palliative Care | 37 | Lowest |

**Surgery alone** yields the best survival outcomes. Palliative care patients — typically Stage IV with metastasis — show the lowest survival, reflecting the stage at which treatment is administered rather than the treatment's effectiveness.

---

## 6. SURVIVAL ANALYSIS

### Overall
- **36.9% survival rate** (553 out of 1,500 patients)
- Average survival across all patients: **31.2 months**

### By Stage
| Stage | Survival Rate | Avg Survival (months) |
|-------|-------------|----------------------|
| Stage I | ~60–65% | ~55–60 months |
| Stage II | ~45–50% | ~40 months |
| Stage III | ~25–30% | ~22 months |
| Stage IV | ~12–15% | ~10–12 months |

> **Key Insight:** Stage I patients survive at **4–5x the rate** of Stage IV patients. Every stage of delay in diagnosis dramatically reduces outcomes. This is the strongest single argument for **population-wide lung cancer screening programs**.

### By Gender
Both genders show similar survival rates, with minor variation by stage. No statistically dominant survival advantage for either gender was observed in this dataset.

---

## 7. KEY FINDINGS SUMMARY

| # | Finding | Implication |
|---|---------|-------------|
| 1 | Early-stage (I/II) patients have dramatically higher survival | Screening programs save lives |
| 2 | Surgery produces best outcomes | Early detection = surgical eligibility |
| 3 | 65% of patients never smoked | Non-smoking risk factors are underappreciated |
| 4 | Western Pacific region has highest patient count | Asia-Pacific needs prioritized resources |
| 5 | Genetic mutations (KRAS/EGFR) appear across all stages | Genetic screening adds clinical value |
| 6 | Palliative care patients (Stage IV) have lowest avg survival | Late diagnosis = limited options |

---

## 8. RECOMMENDATIONS

### For Healthcare Policy Makers
1. **Implement LDCT (Low-Dose CT) screening** for high-risk groups aged 50+, especially current and former smokers.
2. **Fund non-smoker lung cancer research** — the 65% never-smoked rate demands investigation into pollution and genetic risk.
3. **Expand oncology infrastructure in Asia-Pacific** — the Western Pacific bears a disproportionate burden.

### For Clinicians
1. **Do not rule out lung cancer in never-smokers** presenting with respiratory symptoms.
2. **Fast-track surgical assessment** for newly diagnosed Stage I–II patients — the surgical window closes quickly.
3. **Prioritize genetic mutation testing** (KRAS, EGFR) at diagnosis — this informs targeted therapy eligibility.

### For Public Health Campaigns
1. **Reframe messaging beyond smoking** — include secondhand smoke, air quality, and occupational hazards.
2. **Target men aged 50–70** with specific screening reminders.
3. **Partner with employers** in high-risk industries for workplace screening programs.

---

## 9. DATA LIMITATIONS

- The dataset is **likely simulated or anonymized** — real-world datasets rarely have evenly distributed staging.
- No **socioeconomic or insurance data** is included, which affects access to treatment.
- Survival is binary (Yes/No) — in reality, survival analysis uses **Kaplan-Meier curves** for time-to-event data.
- No **follow-up period** is specified, making the survival rate harder to interpret clinically.

---

## 10. TOOLS USED

| Tool | Purpose |
|------|---------|
| Excel | Data cleaning, pivot tables, formulas, summary statistics |
| MySQL / SQL | Data querying, filtering, aggregation, window functions |
| Power BI | Interactive 1-page dashboard with slicers |
| Python (pandas) | Data exploration and pivot analysis |

---

## APPENDIX — DATA DICTIONARY (Selected Columns)

| Column | Type | Description |
|--------|------|-------------|
| Patient_ID | Text | Unique patient identifier |
| Diagnosis_Year | Integer | Year of cancer diagnosis |
| Age | Integer | Patient age at diagnosis |
| Gender | Text | Male / Female |
| Smoking_Status | Text | Never Smoked / Current Smoker / Former Smoker |
| Cancer_Stage | Text | Stage I through Stage IV |
| Tumor_Size_cm | Decimal | Tumor diameter in centimeters |
| Metastasis | Yes/No | Whether cancer has spread to other organs |
| Treatment | Text | Type of treatment received |
| Survival_Months | Integer | Number of months patient survived after diagnosis |
| Survived | Yes/No | Whether patient was alive at end of study period |

---

*Report prepared by Clark | Lung Cancer Dataset Analysis | Portfolio Project*
