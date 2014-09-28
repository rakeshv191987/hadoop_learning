package patent;

import java.io.IOException;

import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class PatentMapper extends
		Mapper<LongWritable, Text, IntWritable, FloatWritable> {

	public void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		String patSub = value.toString();
		String[] patSubPair = patSub.split(" ");

		int patId = Integer.parseInt(patSubPair[0]);
		Float subPatId = Float.parseFloat(patSubPair[0]);

		context.write(new IntWritable(patId), new FloatWritable(subPatId));
	}
}
