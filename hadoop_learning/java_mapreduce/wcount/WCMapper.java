package wcount;

import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WCMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
	private Text word = new Text();
	private IntWritable one = new IntWritable(1);

	public void map(LongWritable key, Text value, Context context)
			throws java.io.IOException, InterruptedException {
		try {
			String line = value.toString();
			StringTokenizer tokens = new StringTokenizer(line);
			while (tokens.hasMoreTokens()) {
				word.set(tokens.nextToken().toLowerCase());
				context.write(word, one);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
