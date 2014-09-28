package patent;

import java.io.IOException;

import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Reducer;

public class PatentReducer extends
		Reducer<IntWritable, FloatWritable, IntWritable, IntWritable> {
	public void reduce(IntWritable key, Iterable<FloatWritable> values, Context context)
			throws IOException, InterruptedException {
		int sum = 0;
		for(@SuppressWarnings("unused") FloatWritable value : values)
			sum ++;
		context.write(key, new IntWritable(sum));
	}

}
