{{ config(materialized='table') }}

select
extract(month from date) as datemonth,

  sum(ads_margin) as ads_margin,
  safe_divide(sum(revenue), nullif(sum(quantity), 0)) as average_basket,
  sum(operational_margin) as operational_margin,
  sum(ads_cost) as ads_cost,
  sum(ads_impression) as ads_impression,
  sum(ads_clicks) as ads_clicks,
  sum(quantity) as quantity,
  sum(revenue) as revenue,
  sum(purchase_cost) as purchase_cost,
  sum(margin) as margin,
  sum(shipping_fee) as shipping_fee,
  sum(log_cost) as log_cost,
  sum(ship_cost) as ship_cost

from {{ ref('finance_campaigns_day') }}
group by datemonth
order by datemonth desc
