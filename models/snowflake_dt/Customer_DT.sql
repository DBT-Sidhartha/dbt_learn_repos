{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='SNOWFLAKE_DT',
    schema= 'Transform_DT',
    target_lag='DOWNSTREAM'
) }}

WITH customer as (
    select 
        cust_id,
        cust_name,
        total_outstanding_amt,
        CRID,
        location,
        cust_created
        FROM snowflake_dt.public.customer
        Qualify row_number() over (partition by cust_id order by cust_created desc) = 1
)

select * from customer