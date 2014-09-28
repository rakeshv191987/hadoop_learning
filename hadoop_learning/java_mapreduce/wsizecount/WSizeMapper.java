package wsizecount;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WSizeMapper extends
		Mapper<LongWritable, Text, Text, IntWritable> {
	private static IntWritable size;
	
	public void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		try {
			String line = value.toString();
			StringTokenizer itr = new StringTokenizer(line);
			while (itr.hasMoreTokens()) {
				String nWord = itr.nextToken();
				size = new IntWritable(nWord.length()); 
				
				context.write(new Text(size+"\t"+nWord),new IntWritable(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
