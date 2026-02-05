select
  o.date_date as date,
  COUNT(DISTINCT(o.orders_id)) as nb_transactions,
  ROUND(SUM(o.revenue),2) as total_revenue,
  ROUND(SAFE_DIVIDE(SUM(o.revenue),COUNT(DISTINCT o.orders_id)),2) as average_basket,
  SUM(o.quantity) as total_quantity_sold,
  ROUND(SUM(o.purchase_cost),2) as total_purchase_cost,
  ROUND(SUM(s.shipping_fee),2) as total_shipping_fees,
  ROUND(SUM(s.logcost),2) as total_log_costs,
  ROUND(SUM (o.operational_margin),2) as operational_margin,
  ROUND(SUM(s.ship_cost),2) as total_ship_cost
from {{ ref('int_orders_operational') }} o
left join {{ ref('stg_raw__ship') }} s
using (orders_id)
group by o.date_date
order by o.date_date desc