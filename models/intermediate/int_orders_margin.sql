SELECT
    orders_id,
    MIN(date_date) AS date_date,
    ROUND(SUM(revenue),2) AS revenue,
    SUM(quantity) AS quantity,
    ROUND(SUM(purchase_cost),2) AS purchase_cost,
    ROUND(SUM(margin),2) AS margin

FROM {{ ref('int_sales_margin') }}

GROUP BY orders_id