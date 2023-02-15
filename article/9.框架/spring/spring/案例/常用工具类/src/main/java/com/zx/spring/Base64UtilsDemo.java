package com.zx.spring;

import org.springframework.util.Base64Utils;

import junit.framework.TestCase;

/**
 * @Project: 20171023_fileRead
 * @Title: Base64UtilsDemo
 * @Description: base64解码编码
 * 		源码中，选择加载自己的实现类。
 * 		// JDK 8's java.util.Base64 class present?
		if (ClassUtils.isPresent("java.util.Base64", Base64Utils.class.getClassLoader())) {
			delegateToUse = new JdkBase64Delegate();
		}
		// Apache Commons Codec present on the classpath?
		else if (ClassUtils.isPresent("org.apache.commons.codec.binary.Base64", Base64Utils.class.getClassLoader())) {
			delegateToUse = new CommonsCodecBase64Delegate();
		}
 * @author: zhangxue
 * @date: 2017年10月25日下午3:31:17
 * @company: yooli
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class Base64UtilsDemo extends TestCase {
	
	public void test(){
		String str = "123456";
		byte[] encode = Base64Utils.encode(str.getBytes());
		byte[] decode = Base64Utils.decode(encode);
		System.out.println(new String(decode));
	}
}
