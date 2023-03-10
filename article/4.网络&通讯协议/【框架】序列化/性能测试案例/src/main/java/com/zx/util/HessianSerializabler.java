package com.zx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.util.StopWatch;

import com.caucho.hessian.io.Hessian2Input;
import com.caucho.hessian.io.Hessian2Output;
import com.zx.entity.User;

import de.ruedigermoeller.serialization.FSTConfiguration;
import de.ruedigermoeller.serialization.FSTObjectInput;
import de.ruedigermoeller.serialization.FSTObjectOutput;

public class HessianSerializabler  {
	
	public static byte[] serializable(Object obj){
		Hessian2Output h2o = null;
		ByteArrayOutputStream baos= null;
		try {
			baos = new ByteArrayOutputStream();
			h2o = new Hessian2Output(baos);
			h2o.writeObject(obj);
			h2o.completeMessage();
			h2o.flush();
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
				if(h2o != null)
				h2o.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T deserializable(byte[] value, Class<T> clazz){
		Hessian2Input h2i = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			h2i = new Hessian2Input(bais); 
			return (T)h2i.readObject();
		} catch (IOException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(bais != null)
					bais.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if(h2i != null)
					h2i.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static <T> List<T> deserializableList(byte[] value, Class<T> clazz){
		Hessian2Input h2i = null;
		ByteArrayInputStream bais= null;
		try {
			bais = new ByteArrayInputStream(value);
			h2i = new Hessian2Input(bais); 
			return (List<T>)h2i.readObject();
		} catch (IOException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(bais != null)
					bais.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if(h2i != null)
					h2i.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
	public static void main(String[] args) {
		// ??????Java??????
		User user = new User(1, "??????", new Date(), "pwd", "123@qq.com");
		// ??????Java ??????
		List<User> list = new ArrayList<User>();
		for (int i = 0; i < 1000; i++) {
			list.add(user);
		}
		StopWatch sw = new StopWatch();
		
		// 1. ?????????javaBean
		sw.start("Hessian?????????javaBean");
		for (int i = 0; i < 1000; i++) {
			byte[] bs = HessianSerializabler.serializable(user);
			HessianSerializabler.deserializable(bs, User.class);
		}
		sw.stop();
		
		// 2. ?????????javaList
		sw.start("Hessian?????????javaList");
		for (int i = 0; i < 1000; i++) {
			byte[] bs2 = HessianSerializabler.serializable(list);
			HessianSerializabler.deserializableList(bs2, User.class);
		}
		sw.stop();
		System.out.println(sw.prettyPrint());
		
//		StopWatch '': running time (millis) = 435
//		-----------------------------------------
//		ms     %     Task name
//		-----------------------------------------
//		00165  038%  Hessian?????????javaBean
//		00270  062%  Hessian?????????javaList

	}
	
}
