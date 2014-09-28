students = load '/user/cloudera/student' using PigStorage('\t') as (name: chararray, roll: int);
results = load '/user/cloudera/results' using PigStorage('\t') as (roll: int, res: chararray);
stud_res = join students by roll, results by roll;
stud_succ = filter stud_res by res == 'pass';
stud_succ_names = foreach stud_succ generate name;
stud_ord = order stud_succ_names by name;
stud_succ_lim = limit stud_ord 5;

dump stud_succ_lim;
