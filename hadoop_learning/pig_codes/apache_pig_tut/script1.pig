register '/user/cloudera/tutorial.jar';

# define UDF'S
define NonUrlDet org.apache.pig.tutorial.NonURLDetector();
define ToLower org.apache.pig.tutorial.ToLower();
define ExtHour org.apache.pig.tutorial.ExtractHour();
define NGramGen org.apache.pig.tutorial.NGramGenerator();

# Filter based on query field - remove if empty or has URL
raw = load '/user/cloudera/data/excite-small.log' using PigStorage('\t') as (user, time, query);
clean1 = filter raw by NonUrlDet(query);

# Lowercase query field 
clean2 = foreach clean1 generate user, time, ToLower(query);

# Extract hour from time
houred = foreach clean2 generate user, ExtHour(time) as hour, query;

# Generate single most common words and most common pairs of words
ngramed1 = foreach houred generate user, hour, flatten(NGramGen(query)) as ngram;

dump ngramed1;
