package com.zx.spring;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import org.springframework.util.ObjectUtils;

/**
 * @Project: 20171023_fileRead
 * @Title: ObjectUtilsDemo
 * @Description: object基本操作
 * @author: zhangxue
 * @date: 2017年10月25日下午2:35:00
 * @company: yooli
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class ObjectUtilsDemo {
	public static void main(String[] args) {
		List<String> li = new ArrayList<String>();
		System.out.println(ObjectUtils.isEmpty(li));//true 判断对象为null、字符串、数组、Map、集合为空等都为true
		
		System.out.println(ObjectUtils.isEmpty(new String[]{}));//ObjectUtils.isEmpty(li)
		
		System.out.println(ObjectUtils.isArray(new String[]{}));//判断对象是否为数组
		
		System.out.println(ObjectUtils.containsElement(new String[]{"1", "1", "2"}, "3"));//判断数据组中是否包含给定的元素
		
		String[] toArray = ObjectUtils.addObjectToArray(new String[]{"1", "1", "2"}, "3");
		System.out.println(Arrays.toString(toArray));
	}
}
