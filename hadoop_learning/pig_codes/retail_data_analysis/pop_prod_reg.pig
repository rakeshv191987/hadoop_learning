/* To find popular product region wise - not working as expected, popular item
not showing */
txns = load '/user/cloudera/pig/txns' using PigStorage(',') as (txnid: chararray, txndate: chararray, custid: chararray, amount: double, category: chararray,product: chararray, city: chararray, state: chararray, paytype: chararray);
/* Get amount, product, city */ 
prod_reg = foreach txns generate $3, $5, $6;
grp_prod_reg = group prod_reg by (product, city);
prod_reg_sum = foreach grp_prod_reg generate flatten(group), SUM(prod_reg.amount) as total_amt;
prod_reg_grp = group prod_reg_sum by city;
prod_reg_max = foreach prod_reg_grp generate group, MAX(prod_reg_sum.total_amt) as max_amt;
prod_desc = order prod_reg_max by max_amt desc;
dump prod_desc; 
