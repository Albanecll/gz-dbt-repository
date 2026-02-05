select
date_date,
paid_source,
sum(ads_cost) as ads_cost,
sum(impression) as impression,
sum(click) as click
from {{ ref('int_campaigns') }}
group by date_date,paid_source
order by date_date desc