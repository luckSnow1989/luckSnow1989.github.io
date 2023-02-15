package com.zx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.objenesis.strategy.StdInstantiatorStrategy;
import org.springframework.util.StopWatch;

import com.esotericsoftware.kryo.Kryo;
import com.esotericsoftware.kryo.io.Input;
import com.esotericsoftware.kryo.io.Output;
import com.esotericsoftware.kryo.serializers.CollectionSerializer;
import com.esotericsoftware.kryo.serializers.JavaSerializer;
import com.esotericsoftware.kryo.serializers.MapSerializer;
import com.zx.entity.User;

public class KryoSerializabler  {
	
	public static <T extends Serializable> byte[] serializationObject(T obj) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.register(obj.getClass(), new JavaSerializer());
 
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Output output = new Output(baos);
        kryo.writeClassAndObject(output, obj);
        output.flush();
        output.close();
 
        byte[] b = baos.toByteArray();
        try {
            baos.flush();
            baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return b;
    }
 
    @SuppressWarnings("unchecked")
    public static <T extends Serializable> T deserializationObject(byte[] obj,  Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.register(clazz, new JavaSerializer());
 
        ByteArrayInputStream bais = new ByteArrayInputStream(obj);
        Input input = new Input(bais);
        return (T) kryo.readClassAndObject(input);
    }
 
    public static <T extends Serializable> byte[] serializationList(List<T> obj,  Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        CollectionSerializer serializer = new CollectionSerializer();
        serializer.setElementClass(clazz, new JavaSerializer());
        serializer.setElementsCanBeNull(false);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(ArrayList.class, serializer);
 
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Output output = new Output(baos);
        kryo.writeObject(output, obj);
        output.flush();
        output.close();
 
        byte[] b = baos.toByteArray();
        try {
            baos.flush();
            baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return b;
    }
 
    @SuppressWarnings("unchecked")
    public static <T extends Serializable> List<T> deserializationList(byte[] obj, Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        CollectionSerializer serializer = new CollectionSerializer();
        serializer.setElementClass(clazz, new JavaSerializer());
        serializer.setElementsCanBeNull(false);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(ArrayList.class, serializer);
 
        ByteArrayInputStream bais = new ByteArrayInputStream(obj);
        Input input = new Input(bais);
        return (List<T>) kryo.readObject(input, ArrayList.class, serializer);
    }
 
    public static <T extends Serializable> byte[] serializationMap( Map<String, T> obj, Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        MapSerializer serializer = new MapSerializer();
        serializer.setKeyClass(String.class, new JavaSerializer());
        serializer.setKeysCanBeNull(false);
        serializer.setValueClass(clazz, new JavaSerializer());
        serializer.setValuesCanBeNull(true);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(HashMap.class, serializer);
 
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Output output = new Output(baos);
        kryo.writeObject(output, obj);
        output.flush();
        output.close();
 
        byte[] b = baos.toByteArray();
        try {
            baos.flush();
            baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return b;
    }
 
    @SuppressWarnings("unchecked")
    public static <T extends Serializable> Map<String, T> deserializationMap(byte[] obj, Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        MapSerializer serializer = new MapSerializer();
        serializer.setKeyClass(String.class, new JavaSerializer());
        serializer.setKeysCanBeNull(false);
        serializer.setValueClass(clazz, new JavaSerializer());
        serializer.setValuesCanBeNull(true);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(HashMap.class, serializer);
 
        ByteArrayInputStream bais = new ByteArrayInputStream(obj);
        Input input = new Input(bais);
        return (Map<String, T>) kryo.readObject(input, HashMap.class,
                serializer);
    }
 
    public static <T extends Serializable> byte[] serializationSet(Set<T> obj, Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        CollectionSerializer serializer = new CollectionSerializer();
        serializer.setElementClass(clazz, new JavaSerializer());
        serializer.setElementsCanBeNull(false);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(HashSet.class, serializer);
 
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Output output = new Output(baos);
        kryo.writeObject(output, obj);
        output.flush();
        output.close();
 
        byte[] b = baos.toByteArray();
        try {
            baos.flush();
            baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return b;
    }
 
    @SuppressWarnings("unchecked")
    public static <T extends Serializable> Set<T> deserializationSet(byte[] obj, Class<T> clazz) {
        Kryo kryo = new Kryo();
        kryo.setReferences(false);
        kryo.setRegistrationRequired(true);
 
        CollectionSerializer serializer = new CollectionSerializer();
        serializer.setElementClass(clazz, new JavaSerializer());
        serializer.setElementsCanBeNull(false);
 
        kryo.register(clazz, new JavaSerializer());
        kryo.register(HashSet.class, serializer);
 
        ByteArrayInputStream bais = new ByteArrayInputStream(obj);
        Input input = new Input(bais);
        return (Set<T>) kryo.readObject(input, HashSet.class, serializer);
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
			byte[] bs = KryoSerializabler.serializationObject(user);
			KryoSerializabler.deserializationObject(bs, User.class);
		}
		sw.stop();
		
		// 2. 序列化javaList
		sw.start("java原生序列化javaList");
		for (int i = 0; i < 1000; i++) {
			byte[] bs2 = KryoSerializabler.serializationList(list, User.class);
			KryoSerializabler.deserializationList(bs2, User.class);
		}
		sw.stop();
		System.out.println(sw.prettyPrint());
		
//		StopWatch '': running time (millis) = 1499
//		-----------------------------------------
//		ms     %     Task name
//		-----------------------------------------
//		00453  030%  java原生序列化javaBean
//		01046  070%  java原生序列化javaList

	}
	
}
