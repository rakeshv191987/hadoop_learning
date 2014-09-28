/* Age wise popular item */
custs = load '/user/cloudera/pig/custs' using PigStorage(',') as (custid: chararray, fname: chararray, lname: chararray, age: long, prof: chararray);
txns = load '/user/cloudera/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
cust_txns = join custs by custid, txns by custid;
/* Just get custid, age, product */
cust_txn = foreach cust_txns generate $0, $3, $10;
cust_grp_age = group cust_txn by (age, product);
pop_itm_age = foreach cust_grp_age generate flatten(group), COUNT(cust_txn.custid) as itm_cnt;
pop_itm_desc = order pop_itm_age by $0;
dump pop_itm_desc;
