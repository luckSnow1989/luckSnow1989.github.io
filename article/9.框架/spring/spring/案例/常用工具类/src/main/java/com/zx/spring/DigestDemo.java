package com.zx.spring;

import java.io.UnsupportedEncodingException;

import org.springframework.util.DigestUtils;

import junit.framework.TestCase;

public class DigestDemo extends TestCase {
	
	public void test() throws UnsupportedEncodingException {
		String asHex = DigestUtils.md5DigestAsHex("123".getBytes());
		System.out.println(asHex);
	}
	
}
