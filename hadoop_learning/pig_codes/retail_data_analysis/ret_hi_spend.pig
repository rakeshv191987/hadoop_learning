/* High spending customers */
custs = load '/user/cloudera/pig/custs' using PigStorage(',') as (custid: chararray, fname: chararray, lname: chararray, age: long, prof: chararray);
txns = load '/user/cloudera/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
cust_txns = join custs by custid, txns by custid;
/* Just get custid, fname, lname, amount */
cust_txn = foreach cust_txns generate $0, $1, $2, $8; 
cust_txns_grp = group cust_txn by custid;
cust_txns_sum = foreach cust_txns_grp generate group, SUM(cust_txn.amount) as total_amt;
cust_hi_amt = order cust_txns_sum by total_amt DESC;
cust_hi100 = limit cust_hi_amt 100;
dump cust_hi100;
