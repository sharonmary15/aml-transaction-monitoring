-- AML Transaction Monitoring: SQL Detection Queries
-- Dataset: IBM HI-Small AML (5.07M transactions, 5177 laundering)

-- 1. High-velocity accounts (reveals banks/institutions, not launderers)
SELECT Account, COUNT(*) AS num_transactions,
       SUM(Amount_Paid) AS total_paid,
       SUM(Is_Laundering) AS laundering_count
FROM transactions
GROUP BY Account
HAVING COUNT(*) > 50
ORDER BY num_transactions DESC;

-- 2. Laundering vs legitimate amount signature
SELECT Is_Laundering, COUNT(*) AS num_transactions,
       AVG(Amount_Paid) AS avg_amount,
       MIN(Amount_Paid) AS min_amount,
       MAX(Amount_Paid) AS max_amount
FROM transactions
GROUP BY Is_Laundering;

-- 3. Accounts concentrated in laundering (true mule accounts)
SELECT Account,
       SUM(CASE WHEN Is_Laundering = 1 THEN 1 ELSE 0 END) AS laundering_txns,
       COUNT(*) AS total_txns,
       ROUND(100.0 * SUM(CASE WHEN Is_Laundering = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS laundering_pct
FROM transactions
GROUP BY Account
HAVING laundering_txns > 0
ORDER BY laundering_pct DESC, laundering_txns DESC;
