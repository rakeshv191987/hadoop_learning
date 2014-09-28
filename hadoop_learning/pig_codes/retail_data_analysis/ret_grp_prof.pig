/* Count of profession of all customers */
custs = load '/user/cloudera/pig/custs' using PigStorage(',') as (custid: chararray, fname: chararray, lname: chararray, age: long, prof: chararray);
txns = load '/user/cloudera/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
cust_grp = group custs by prof;
cust_grp_cnt = foreach cust_grp generate group, COUNT(custs.prof);
dump cust_grp_cnt;


