package wcount;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WCReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
	public void reduce(Text key, Iterable<IntWritable> itr, Context context) 
			throws java.io.IOException, InterruptedException {
		int sum = 0;
		for(IntWritable x:itr){
			sum += x.get();
		}
		context.write(key, new IntWritable(sum));
	}
}
