package maxtemp;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MaxTempMapper extends
		Mapper<LongWritable, Text, IntWritable, IntWritable> {
	private IntWritable year = new IntWritable();
	private IntWritable temp = new IntWritable();
	private static String keyVal;
	private static String[] keyValPair;
	
	public void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		keyVal= value.toString();
		keyValPair = keyVal.split(" ");
		
		year = new IntWritable(Integer.parseInt(keyValPair[0]));
		temp = new IntWritable(Integer.parseInt(keyValPair[1]));
		context.write(year, temp);
	}
}
