SELECT
  LoanID,
  Age,
  Income,
  LoanAmount,
  CreditScore,
  MonthsEmployed,
  NumCreditLines,
  InterestRate,
  LoanTerm,
  DTIRatio,
  Education,
  EmploymentType,
  MaritalStatus,
  HasMortgage,
  HasDependents,
  LoanPurpose,
  HasCoSigner,
  `Default` as is_default,
  case
    when CreditScore < 580 then 'Poor'
    when CreditScore < 670 then 'Fair'
    when CreditScore < 740 then 'Good'
    when CreditScore < 800 then 'Very Good'
    else 'Excellent'
  end as credit_score_band,
  case
    when DTIRatio <= 0.36 then 'Healthy'
    else 'High Risk'
  end as dti_risk_flag,
  round(LoanAmount / NULLIF(Income, 0), 2) as loan_to_income_ratio
FROM {{ ref('stg_raw_loan_default') }}