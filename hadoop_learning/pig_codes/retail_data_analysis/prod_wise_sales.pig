/* Product wise sales */
txns = load '/user/cloudera/pig/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
/* Get amount, category, product */
prod_det = foreach txns generate $3, $4, $5;
grp_prod_det = group prod_det by product;
prod_sum = foreach grp_prod_det generate group, prod_det.category, SUM(prod_det.amount) as total_sales;
top20prod = limit prod_sum 20;
top20desc = order top20prod by total_sales desc;
dump top20desc;
