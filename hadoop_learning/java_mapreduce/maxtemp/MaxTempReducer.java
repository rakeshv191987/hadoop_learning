package maxtemp;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Reducer;

public class MaxTempReducer extends
		Reducer<IntWritable, IntWritable, IntWritable, IntWritable> {
	
	public void reduce(IntWritable key, Iterable<IntWritable> values,
			Context context) throws IOException, InterruptedException {
		int maxTemp = 0;
		for(IntWritable val : values) {
			if (val.get() > maxTemp)
				maxTemp = val.get();
		}
		context.write(key, new IntWritable(maxTemp));
	}
}
