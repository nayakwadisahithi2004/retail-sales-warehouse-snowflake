desc table snowflake_sample_data.TPCDS_SF100TCL.CUSTOMER;

desc table snowflake_sample_data.tpcds_sf100tcl.customer_address;

USE WAREHOUSE COFFEE_SHOP_WH;

USE DATABASE SNOWFLAKE_LEARNING_DB;

create or replace table silver.customer_dim(
       customer_sk number autoincrement,
       customer_id number,
       state string,
       start_date date,
       end_date date,
       is_current string
);

insert into silver.customer_dim
(customer_id,state,start_date,end_date,is_current)
select c.c_customer_sk,ca.ca_state,current_date,null,'Y'
from snowflake_sample_data.tpcds_sf100tcl.customer c
join snowflake_sample_data.tpcds_sf100tcl.customer_address ca
on c.c_current_addr_sk=ca.ca_address_sk;

select count(*) from silver.customer_dim;

select * from silver.customer_dim limit 5;

--create a small stage
create or replace table silver.customer_stage as
select customer_id,state
from silver.customer_dim
where is_current='Y';

--manually update one row
update silver.customer_stage
set state='TX'
where customer_id=83369285;

select * from silver.customer_stage where customer_id=83369285;

--implementing stage 2 using merge

  

SELECT *
FROM silver.customer_dim
WHERE customer_id = 83369285
ORDER BY start_date;