use database snowflake_sample_data;

select count(*)
from tpcds_sf100tcl.store_sales;
use warehouse COMPUTE_WH;
use database SNOWFLAKE_LEARNING_DB;

create schema if not exists BRONZE;
create or replace table BRONZE.STORE_SALES_RAW as
select *
from snowflake_sample_data.tpcds_sf100tcl.store_sales
limit 50000000;

--phase 3: Data Validation(Completeness)
SELECT count(*) from BRONZE.STORE_SALES_RAW;

select count(*)
from snowflake_sample_data.tpcds_sf100tcl.store_sales;

desc table bronze.store_sales_raw;

select count(*) as total_rows,count(ss_sales_price) as non_null_sales_price
from bronze.store_sales_raw;

--optional

select min(ss_sold_date_sk),max(ss_sold_date_sk)
from bronze.store_sales_raw;