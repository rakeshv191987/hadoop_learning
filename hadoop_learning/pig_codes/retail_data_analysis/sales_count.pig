/* sales count of 5  stores */
register '/usr/lib/pig/contrib/piggybank/java/piggybank.jar'
sales_data = load '/user/cloudera/pig/train.csv' using org.apache.pig.piggybank.storage.CSVLoader();
sales_dataset_grouped = group sales_data by $0;
sales_data5 = limit sales_dataset_grouped 5;
sales_rec_num = foreach sales_data5 generate group, COUNT(sales_data);
dump sales_rec_num;
