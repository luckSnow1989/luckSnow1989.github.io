package com.zx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.util.StopWatch;

import com.zx.entity.User;

public class JavaSerializabler  {
	
	public static byte[] serializable(Object obj){
		ObjectOutput oo = null;
		ByteArrayOutputStream baos= null;
		try {
			baos = new ByteArrayOutputStream();
			oo = new ObjectOutputStream(baos);
			oo.writeObject(obj);
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
			try {
				if(oo != null)
					oo.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T deserializable(byte[] value, Class<T> clazz){
		ObjectInput oi = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			oi = new ObjectInputStream(bais);
			return (T)oi.readObject();
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
			try {
				if(oi != null)
					oi.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> List<T> deserializableList(byte[] value, Class<T> clazz){
		ObjectInput oi = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			oi = new ObjectInputStream(bais);
			return (List<T>)oi.readObject();
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
			try {
				if(oi != null)
					oi.close();
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
		sw.start("java原生序列化javaBean");
		for (int i = 0; i < 1000; i++) {
			byte[] bs = JavaSerializabler.serializable(user);
			JavaSerializabler.deserializable(bs, User.class);
		}
		sw.stop();
		
		// 2. 序列化javaList
		sw.start("java原生序列化javaList");
		for (int i = 0; i < 1000; i++) {
			byte[] bs2 = JavaSerializabler.serializable(list);
			JavaSerializabler.deserializableList(bs2, User.class);
		}
		sw.stop();
		System.out.println(sw.prettyPrint());
		
//		StopWatch '': running time (millis) = 979
//		-----------------------------------------
//		ms     %     Task name
//		-----------------------------------------
//		00276  028%  java原生序列化javaBean
//		00703  072%  java原生序列化javaList
	}
	
}
