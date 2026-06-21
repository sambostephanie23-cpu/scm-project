SELECT
  Item_Category,
  COUNT(DISTINCT PO_ID) as order_count,
  SUM(total_negotiated_price) as category_spend,
  ROUND(SUM(on_time_flag) / COUNT(*) * 100, 1) as on_time_pct,
  ROUND(AVG(defect_rate) * 100, 2) as avg_defect_rate_pct,
  ROUND(SUM(price_savings_per_unit * Quantity), 2) as category_savings
FROM {{ ref('fct_procurement_metrics') }}
GROUP BY Item_Category
ORDER BY category_spend DESC