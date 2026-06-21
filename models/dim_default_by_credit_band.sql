SELECT
  credit_score_band,
  COUNT(*) as total_loans,
  SUM(is_default) as total_defaults,
  ROUND(SUM(is_default) / COUNT(*) * 100, 2) as default_rate_pct,
  ROUND(AVG(InterestRate), 2) as avg_interest_rate,
  ROUND(AVG(LoanAmount), 0) as avg_loan_amount
FROM {{ ref('fct_loan_default') }}
GROUP BY credit_score_band
ORDER BY default_rate_pct DESC