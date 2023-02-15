package com.hadoop;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class Example extends Configured implements Tool{
	
	enum Counter{
		LINEIMPORT,//输入行数
		LINEEXPORT,//输出行数
		LINESKIP//出错的行
	}
	
	public static class Map extends Mapper<LongWritable, Text, Text, Text> {
		public void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			String line = value.toString();//key是行号，value是一行数据的字符串
			try {
				String[] lineSplit = line.split(" ");
				String zhu = lineSplit[0];//主叫号码
				String bei = lineSplit[1];//被叫号码
				
				context.write(new Text(zhu), new Text(bei));
			} catch (Exception e) {
				context.getCounter(Counter.LINESKIP).increment(1);//出错后计数器+1
				return;
			} finally {
				context.getCounter(Counter.LINEIMPORT).increment(1);//输入行数+1
			}			
		}
	}
		
	public static class Reduce extends Reducer<Text, Text, Text, Text> {
		@Override
		protected void reduce(Text key, Iterable<Text> values, Reducer<Text, Text, Text, Text>.Context context)
				throws IOException, InterruptedException {
			try {
				java.util.Map<Text, Double> count = new HashMap<>();
				for (Text text : values) {
					if(!count.containsKey(text)) {
						count.put(text, 1d);
					} else {
						count.put(text, count.get(text).doubleValue() + 1);
					}
				}
				
				Set<Entry<Text, Double>> es = count.entrySet();
				StringBuffer out = new StringBuffer();
				for (Entry<Text, Double> e : es) {
					out.append("[").append(e.getKey().toString()).append("=").append(e.getValue().doubleValue()).append("],");
				}
				context.write(key, new Text(out.toString()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			context.getCounter(Counter.LINEEXPORT).increment(1);//输出行数+1
		}
	}
	
	
	@Override
	public int run(String[] args) throws Exception {
		Configuration conf = getConf();
		
		Job job = new Job(conf, "Rphone");//任务名
		job.setJarByClass(Example.class);//指定运行时的class
	
		FileInputFormat.addInputPath(job, new Path(args[0]));//指定输入路径
		FileOutputFormat.setOutputPath(job, new Path(args[1]));//指定输出路径
		
		job.setMapperClass(Map.class);
		job.setReducerClass(Reduce.class);
		job.setOutputFormatClass(TextOutputFormat.class);
		job.setOutputKeyClass(Text.class);//输出的key的格式
		job.setOutputValueClass(Text.class);//输出的value的格式
		
		job.waitForCompletion(true);
		
		System.out.println("任务名称："+ job.getJobName());
		System.out.println("任务成功："+ job.isSuccessful());
		System.out.println("输入行数："+ job.getCounters().findCounter(Counter.LINEIMPORT).getValue());
		System.out.println("输出行数："+ job.getCounters().findCounter(Counter.LINEEXPORT).getValue());
		System.out.println("跳过行数："+ job.getCounters().findCounter(Counter.LINESKIP).getValue());
		return job.isSuccessful()?0:1;
	}

	
	
	
	public static void main(String[] args) {
		try {
			int run = ToolRunner.run(new Configuration(), new Example(), args);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
