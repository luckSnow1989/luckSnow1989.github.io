package com.zx.spring;

import org.springframework.util.StopWatch;

/**
 * @Project: 20171023_fileRead
 * @Title: StopWatchDemo
 * @Description: 
 * 		有时我们在做开发的时候需要记录每个任务执行时间，或者记录一段代码执行时间，
 * 		最简单的方法就是打印当前时间与执行完时间的差值，然后这样如果执行大量测试的话就很麻烦，并且不直观，
 * 		如果想对执行的时间做进一步控制，则需要在程序中很多地方修改，目前spring-framework提供了一个
 * 		StopWatch类可以做类似任务执行时间控制，也就是封装了一个对开始时间，结束时间记录操作的Java类。
 * @author: zhangxue
 * @date: 2017年10月25日上午11:13:56
 * @company: yooli
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class StopWatchDemo {
	
	public static void main(String[] args) throws InterruptedException {
		StopWatch watch = new StopWatch();
		
		watch.start("起床");
		Thread.sleep(1000);
		watch.stop();
		
		watch.start("洗漱");
		Thread.sleep(1000);
		watch.stop();
		
		watch.start("出门");
		Thread.sleep(1000);
		watch.stop();
		
		System.out.println("任务详情\r" + watch.prettyPrint());
        System.out.println("所有任务的总时间=" + watch.getTotalTimeMillis());
        System.out.println("最后一个任务的名称=" + watch.getLastTaskName());
        System.out.println("最后一个任务的名称的详情=" + watch.getLastTaskInfo());
        System.out.println("任务的数量=" + watch.getTaskCount());
	}
}
