/* Department wise sales for a store */
/* Data - Store, Dept, Date, Weekly_sales, isHoliday */
register '/usr/lib/pig/contrib/piggybank/java/piggybank.jar';
sales_data = load '/user/cloudera/pig/train.csv' using org.apache.pig.piggybank.storage.CSVLoader();
/* Get Store, Dept, Weekly_sales */
filt_data = foreach sales_data generate $0, $1, $3;
grp_data = group filt_data by ($0, $1);
sum_dept_sales = foreach grp_data generate flatten(group), SUM(filt_data.$2) as total_sales;
grp_by_store = group sum_dept_sales by $0;
dept_store_max_sales = foreach grp_by_store generate group, sum_dept_sales.$1, MAX(sum_dept_sales.$2); 
dump dept_store_max_sales;
/* Can't get the dept associated with max sales for a store */
