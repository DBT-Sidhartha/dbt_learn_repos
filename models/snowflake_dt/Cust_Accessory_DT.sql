{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='SNOWFLAKE_DT',
    schema= 'Transform_DT',
    target_lag='3 MINUTES'
) }}

WITH Cust_Accessory_DT as (
    select 
        c.cust_id,
        c.cust_name,
        c.crid,
        c.location,
        c.cust_created,
        a.acc_id,
        a.acc_category,
        a.acc_status,
        a.price as acc_price,
        a.acc_count,
        a.price/ a.acc_count as Price_Per_Accessory
    from {{ ref('Customer_DT') }} c
    left join {{ ref('Accessory_DT') }} a
    on c.cust_id = a.cust_id
)
select * from Cust_Accessory_DT