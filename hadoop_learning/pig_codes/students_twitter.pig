students = load '/user/cloudera/data/students.txt' using PigStorage('\t') as (first: chararray, last: chararray, age:int, dept: chararray);

/* 1. Group count of students by dept */
studgrp = foreach (group students by dept) generate group as dept, COUNT_STAR(students);

/* 2. Percentage of each age group against the total */
studagegrp = foreach (group students by age) generate group as age, COUNT_STAR(stud) as ct;
studagetotal = foreach (group studagegrp all) generate flatten(studagegrp.(age, ct)), SUM(studagegrp.ct) as total;
studperc = foreach studagetotal generate age, (double)ct/total;
dump studperc;

/* 3. Credits needed by each student */
dprt = load '/user/cloudera/data/dept_info.txt' using PigStorage('\t') as (deptn: chararray, credits: int);
credneed = foreach (join students by dept, dprt by deptn) generate students::first, students::last, dprt::credits;
dump credneed;

/* 4. Flatten multiple bags efficiently */
studdept = group students by dept;
studproj = foreach studdept generate flatten(students.(first, age));



