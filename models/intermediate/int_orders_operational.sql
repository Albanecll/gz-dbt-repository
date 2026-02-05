--Operational_margin = margin + shipping_fee - log_cost - ship_cost

select
  o.orders_id,
  o.date_date,
  o.revenue,
  o.quantity,
  o.purchase_cost,
  o.margin,
  ROUND(o.margin + ifnull(s.shipping_fee, 0) - ifnull(s.logcost, 0)- ifnull(s.ship_cost, 0),2) as operational_margin
from {{ ref('int_orders_margin') }} o
left join {{ ref('stg_raw__ship') }} s
using (orders_id)