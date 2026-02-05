with sales as (

    select *
    from {{ ref('stg_raw__sales') }}

),

product as (

    select *
    from {{ ref('stg_raw__product') }}

),

joined as (

    select
        s.date_date,
        s.orders_id,
        s.products_id,
        s.quantity,
        s.revenue,
        p.purchase_price,

        -- calcul du purchase cost
        s.quantity * p.purchase_price as purchase_cost,

        -- calcul de la marge
        s.revenue - (s.quantity * p.purchase_price) as margin

    from sales s
    left join product p
        on s.products_id = p.products_id
)

select *
from joined