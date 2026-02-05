---ads_margin = operational_margin - ads_cost

{{ config(materialized="view") }}

with campaigns as (
  select
    date_date,
    ads_cost,
    impression as ads_impression,
    click as ads_clicks
  from {{ ref('int_campaigns_day') }}
),

finance as (
  select
    date,
    average_basket,
    operational_margin,
    total_revenue as revenue,
    total_quantity_sold as quantity,
    total_purchase_cost as purchase_cost,
    total_shipping_fees as shipping_fee,
    total_log_costs as log_cost,
    total_ship_cost as ship_cost
  from {{ ref('finance_days') }}
)

select
  f.date,

  -- ads part
  (f.operational_margin - c.ads_cost) as ads_margin,
  f.operational_margin,
  c.ads_cost,
  c.ads_impression,
  c.ads_clicks,

  -- finance part
  f.quantity,
  f.revenue,
  f.purchase_cost,
  f.average_basket,
  (f.revenue - f.purchase_cost) as margin,
  f.shipping_fee,
  f.log_cost,
  f.ship_cost

from finance f
left join campaigns c
  on c.date_date = f.date

order by f.date desc
