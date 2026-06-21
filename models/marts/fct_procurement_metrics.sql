SELECT
  PO_ID,
  Supplier,
  Order_Date,
  Delivery_Date,
  Item_Category,
  Order_Status,
  Quantity,
  Unit_Price,
  Negotiated_Price,
  Defective_Units,
  Compliance,
  date_diff(Delivery_Date, Order_Date, day) as days_to_deliver,
  case when date_diff(Delivery_Date, Order_Date, day) <= 30 then 1 else 0 end as on_time_flag,
  (Unit_Price - Negotiated_Price) as price_savings_per_unit,
  (Negotiated_Price * Quantity) as total_negotiated_price,
  safe_divide(Defective_Units, Quantity) as defect_rate,
  case when safe_divide(Defective_Units, Quantity) <= 0.5 then 1 else 0 end as quality_flag
FROM {{ ref('stg_raw_procurement') }}
WHERE PO_ID is not null