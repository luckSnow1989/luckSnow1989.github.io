package com.zx.spring;

import java.io.IOException;

import org.apache.commons.io.FileSystemUtils;

import junit.framework.TestCase;

public class FileSystemDemo extends TestCase {
	
	public void test() {
		try {
			long freeSpaceKb = FileSystemUtils.freeSpaceKb("E:\\");
			System.out.println(freeSpaceKb / 1024 / 1024);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
