package com.zx.spring;

import java.math.BigDecimal;

import org.springframework.util.NumberUtils;

/**
 * @Project: 20171023_fileRead
 * @Title: NumberUtilsDemo
 * @Description: 数字类型格式转换
 * 		转换异常抛出：java.lang.NumberFormatException
 * @author: zhangxue
 * @date: 2017年10月25日下午2:54:23
 * @company: yooli
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class NumberUtilsDemo {
	public static void main(String[] args) {
		String numStr = "11.11";
		System.out.println(NumberUtils.parseNumber(numStr, BigDecimal.class));
	}
}
