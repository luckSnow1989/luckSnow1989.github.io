package com.zx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.util.StopWatch;

import com.zx.entity.User;

import de.ruedigermoeller.serialization.FSTConfiguration;
import de.ruedigermoeller.serialization.FSTObjectInput;
import de.ruedigermoeller.serialization.FSTObjectOutput;

public class FstSerializabler  {
	private static FSTConfiguration CONFIGURATION = 
			FSTConfiguration.createDefaultConfiguration();
	
	public static byte[] serializable(Object obj){
		FSTObjectOutput fo = null;
		ByteArrayOutputStream baos= null;
		try {
			baos = new ByteArrayOutputStream();
			fo = CONFIGURATION.getObjectOutput(baos);
			fo.writeObject(obj);
			return baos.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(baos != null)
					baos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T deserializable(byte[] value, Class<T> clazz){
		FSTObjectInput fi = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			fi = CONFIGURATION.getObjectInput(bais);
			return (T)fi.readObject();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(bais != null)
					bais.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> List<T> deserializableList(byte[] value, Class<T> clazz){
		FSTObjectInput fi = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			fi = CONFIGURATION.getObjectInput(bais);
			return (List<T>)fi.readObject();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(bais != null)
					bais.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
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
		sw.start("FST序列化javaBean");
		for (int i = 0; i < 1000; i++) {
			byte[] bs = FstSerializabler.serializable(user);
			FstSerializabler.deserializable(bs, User.class);
		}
		sw.stop();
		
		// 2. 序列化javaList
		sw.start("FST序列化javaList");
		for (int i = 0; i < 1000; i++) {
			byte[] bs2 = FstSerializabler.serializable(list);
			FstSerializabler.deserializableList(bs2, User.class);
		}
		sw.stop();
		System.out.println(sw.prettyPrint());
		
//		StopWatch '': running time (millis) = 450
//		-----------------------------------------
//		ms     %     Task name
//		-----------------------------------------
//		00061  014%  FST序列化javaBean
//		00389  086%  FST序列化javaList

	}
	
}
