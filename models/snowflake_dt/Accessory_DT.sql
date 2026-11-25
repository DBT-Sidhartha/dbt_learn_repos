{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='SNOWFLAKE_DT',
    schema= 'Transform_DT',
    target_lag='DOWNSTREAM'
) }}

WITH 
max_price AS (
    select 
        cust_id,acc_id,
        max(acc_price) as price
        FROM snowflake_dt.public.accessory_item
        group by all
),
Accessory_DT as (
    select 
       a.cust_id,
       a.acc_id,acc_category, acc_status,price, acc_count
    FROM snowflake_dt.public.accessory_item a
    join max_price m
    on a.acc_id = m.acc_id 
    and a.cust_id = m.cust_id
    and a.acc_price = m.price
)
select * from Accessory_DT