package retail;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Partitioner;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class SalesByCategory {

	public static class SalesByCategoryMapper extends
			Mapper<LongWritable, Text, Text, FloatWritable> {
		private Text category = new Text();
		private FloatWritable sale = new FloatWritable();

		public void map(LongWritable key, Text value, Context context)
				throws IOException, InterruptedException {
			String retailText = value.toString();
			String[] attr = retailText.split("\t");

			category.set(attr[3]);
			sale.set(Float.parseFloat(attr[4]));
			context.write(category, sale);
		}
	}

	public static class SalesByCategoryReducer extends
			Reducer<Text, FloatWritable, Text, FloatWritable> {
		public void reduce(Text category, Iterable<FloatWritable> inSale,
				Context context) throws IOException, InterruptedException {
			Float sum = 0F;
			for (FloatWritable sale : inSale) {
				sum += sale.get();
			}
			context.write(category, new FloatWritable(sum));
		}
	}
	
	public static class SalePartitioner extends Partitioner<Text, FloatWritable> {

		@Override
		public int getPartition(Text key, FloatWritable value, int numPartitions) {
			String mKey = key.toString().toLowerCase();
			int cKey = (int)mKey.charAt(0); 
			
			if(cKey >= 97 && cKey <= 105)
				return 0;
			else if(cKey >= 106 && cKey <= 114)
				return 1;
			else 
				return 2;
		}
	}
	
	public static void main(String[] args) throws Exception{
		Configuration conf = new Configuration();
		Job job = new Job(conf, "Sales by Category");
		job.setJarByClass(SalesByCategory.class);
		
		job.setNumReduceTasks(3);
		job.setMapperClass(SalesByCategoryMapper.class);
		job.setCombinerClass(SalesByCategoryReducer.class);
		job.setPartitionerClass(SalePartitioner.class);
		job.setReducerClass(SalesByCategoryReducer.class);
		
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(FloatWritable.class);
		
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		
		job.waitForCompletion(true);
	}
}
