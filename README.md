# AML Transaction Monitoring System

Detecting money laundering in 5 million financial transactions using SQL pattern analysis, machine learning, and a Power BI triage dashboard. Built on IBM's synthetic AML dataset.

**Headline results:** caught 69% of money laundering, with a risk-scored High tier that holds 30% precision and captures 57% of all laundering for efficient analyst triage.

---

## The Problem

Banks and fintechs are legally required to monitor transactions for money laundering and report suspicious activity. The challenge is that laundering is rare (about 0.1% of transactions here) and deliberately designed to look normal, so detection systems generate many alerts that human analysts must triage. This project builds that end-to-end workflow.

## Approach

**1. SQL pattern exploration.** I loaded the data into SQLite and used SQL to find where laundering hides. Key finding: high-volume accounts are banks, not launderers. The real laundering signature is low-volume, single-purpose mule accounts where nearly all activity is illicit.

**2. Machine learning detection.** I engineered features from the SQL insights and trained two models:

| Method | Recall | Precision | Verdict |
|--------|--------|-----------|---------|
| Random Forest (supervised) | 69% | 12% | The working detector |
| Isolation Forest (unsupervised) | 2% | 2% | Fails: laundering isn't statistical outliers |

**3. Risk scoring and triage dashboard.** Rather than a flat flag, I scored each transaction's laundering probability and tiered it High/Medium/Low, then built a Power BI dashboard for analysts to work the highest-risk alerts first.

## Key Insight

The 69% recall at 12% precision is an honest AML result, not a weakness. Laundering is designed to look normal, so no model reaches the near-perfect accuracy of a fraud detector. Compliance teams accept lower precision to avoid missing laundering, then triage alerts manually, which is exactly what the dashboard supports. The High-risk tier concentrates the signal: 30% precision and 57% of all laundering, so analysts review a fraction of transactions while catching most of the crime.

## Tools

SQL (SQLite), Python (pandas, scikit-learn), Random Forest and Isolation Forest, and Power BI for the analyst triage dashboard.

## Files

- `AML_Transaction_Monitoring.ipynb` — the full analysis, start to finish
- `aml_queries.sql` — the SQL detection queries
- `aml_dashboard.png` — the Power BI triage dashboard

## A Note on the Data

IBM's AML dataset is synthetic, so patterns are cleaner than real-world laundering. The methods and the analytical reasoning are what transfer; real laundering rates are even lower, which makes minimising false positives even more important.

---

**About me:** I'm Sharonmary Lazer Baptist Anthony, building a data analytics portfolio focused on financial crime, fraud, and risk, and targeting data analyst roles where this kind of work matters.

Connect on [LinkedIn](https://www.linkedin.com/in/sharonmary-anthony-516078361).
