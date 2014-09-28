/* Date of maximum sales on a holiday */
/* Store, Dept, Date, Weekly_sales, isHoliday */
register '/usr/lib/pig/contrib/piggybank/java/piggybank.jar';
sales_data = load '/user/cloudera/pig/train.csv' using org.apache.pig.piggybank.storage.CSVLoader();
sales_hol = filter sales_data by $4 == 'TRUE';
sales_hol_grp = group sales_hol by ($0, $2);
sales_hol_sum = foreach sales_hol_grp generate flatten(group), SUM(sales_hol.$3) as total_sales;
max_sales = order sales_hol_sum by total_sales DESC;
max_sales_top10 = limit max_sales 10;
--dump max_sales_top10;
store max_sales_top10 into '/user/cloudera/pig/max_hol_sales/' using PigStorage(',');
