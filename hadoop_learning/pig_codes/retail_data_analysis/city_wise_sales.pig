/* City wise sales in amount */
txns = load '/user/cloudera/pig/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
/* txnid, amount, city */
txns_req_fld = foreach txns generate $1, $3, $6;
txn_grp_city = group txns_req_fld by city;
city_sale_sum = foreach txn_grp_city generate group, SUM(txns_req_fld.amount) as total_sales;
city_top = order city_sale_sum by total_sales DESC;
city_top10 = limit city_top 10;
dump city_top10;
