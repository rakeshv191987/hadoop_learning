/* Find out safe cuisines : A-safe, B-safe/ok, C-stay away */
register '/usr/lib/pig/contrib/piggybank/java/piggybank.jar';
cuisdata = load '/user/cloudera/pig/Cuisine.txt' using org.apache.pig.piggybank.storage.CSVLoader() as (cuisinecode: chararray, cuisinename: chararray);
filtcuis = filter cuisdata by cuisinename != 'Other' and cuisinename != 'Not Listed/Not Applicable';
/* Load restaurants data - WebExtract */
restos = load '/user/cloudera/pig/WebExtract.txt' using org.apache.pig.piggybank.storage.CSVLoader() as (camis: chararray, dba: chararray, boro: chararray, building: chararray, street: chararray, zipcode: chararray, phone: chararray, cuisinecode: chararray, inspdate: chararray, action: chararray, violcode: chararray, score: chararray, currentgrade: chararray, gradedate: chararray, recorddate: chararray);
gradedrestos = filter restos by currentgrade is not null and currentgrade != '' and currentgrade != 'P' and currentgrade != 'Z';
genrest = foreach gradedrestos generate dba, currentgrade, cuisinecode;
restcuis = join genrest by cuisinecode, filtcuis by cuisinecode;
agrade = filter restcuis by currentgrade
