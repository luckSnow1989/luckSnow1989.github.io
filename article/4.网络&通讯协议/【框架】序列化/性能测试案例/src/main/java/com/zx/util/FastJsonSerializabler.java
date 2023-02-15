package com.zx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.util.StopWatch;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zx.entity.User;

import de.ruedigermoeller.serialization.FSTConfiguration;
import de.ruedigermoeller.serialization.FSTObjectInput;
import de.ruedigermoeller.serialization.FSTObjectOutput;

public class FastJsonSerializabler  {
	
	public static String serializable(Object obj){
		return JSONObject.toJSON(obj).toString();
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T deserializable(String value, Class<T> clazz){
		return (T)JSONObject.parse(value);
	}
	
	@SuppressWarnings("unchecked")
	public static <T> List<T> deserializableList(String value, Class<T> clazz){
		return (List<T>)JSONObject.parse(value);
	}
	
	
	public static void main(String[] args) {
		// 模拟Java对象
		User user = new User(1, "张三", new Date(), "pwd", "123@qq.com");
		// 模拟Java 集合
		List<User> list = new ArrayList<User>();
		for (int i = 0; i < 1000; i++) {
			list.add(user);
		}
		StopWatch sw = new StopWatch();
		
		// 1. 序列化javaBean
		sw.start("fastJSON序列化javaBean");
		for (int i = 0; i < 1000; i++) {
			String bs = FastJsonSerializabler.serializable(user);
			FastJsonSerializabler.deserializable(bs, User.class);
		}
		sw.stop();
		
		// 2. 序列化javaList
		sw.start("fastJSON序列化javaList");
		for (int i = 0; i < 1000; i++) {
			String bs2 = FastJsonSerializabler.serializable(list);
			FastJsonSerializabler.deserializableList(bs2, User.class);
		}
		sw.stop();
		System.out.println(sw.prettyPrint());
		
//		StopWatch '': running time (millis) = 3150
//		-----------------------------------------
//		ms     %     Task name
//		-----------------------------------------
//		00279  009%  fastJSON序列化javaBean
//		02871  091%  fastJSON序列化javaList

	}
	
}
