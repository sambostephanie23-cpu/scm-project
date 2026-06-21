SELECT
  Supplier,
  count(PO_ID) as total_orders,
  sum(Unit_Price) as total_units,
  sum(total_negotiated_price) as total_spend,
  round(avg(days_to_deliver)) as avg_delivery_days,
  ROUND(SUM(on_time_flag) / COUNT(*) * 100, 1) as on_time_delivery_pct,
  ROUND(AVG(defect_rate) * 100, 2) as avg_defect_rate_pct,
  ROUND(SUM(quality_flag) / COUNT(*) * 100, 1) as quality_score_pct,
  ROUND(SUM(price_savings_per_unit * Quantity), 2) as total_savings_realized,
  COUNTIF(Compliance = TRUE) as compliant_orders,
  ROUND(COUNTIF(Compliance = TRUE) / COUNT(*) * 100, 1) as compliance_pct
FROM {{ ref('fct_procurement_metrics') }}
GROUP BY Supplier
ORDER BY total_spend DESC