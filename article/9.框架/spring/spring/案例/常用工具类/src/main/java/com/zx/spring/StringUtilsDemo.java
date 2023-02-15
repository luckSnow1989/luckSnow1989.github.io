package com.zx.spring;

import org.springframework.util.StringUtils;

import junit.framework.TestCase;
/**
 * @Project: 20171023_fileRead
 * @Title: StringUtilsDemo
 * @Description: 字符串处理类
 * 			空白字符是指空格、制表符（\t）回车符（\n）或换行符（\r）
 * @author: zhangxue
 * @date: 2017年10月25日下午2:34:16
 * @company: yooli
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class StringUtilsDemo extends TestCase {

	public void test() {
		System.out.println(StringUtils.isEmpty(""));//等效于		str == null || "".equals(str)
		System.out.println(StringUtils.hasLength("1"));//true	字符串长度是否大于1
		System.out.println(StringUtils.hasText("  "));//false 判断字符串中是否有字符
		System.out.println(StringUtils.containsWhitespace(" 1 "));//true	是否包含空白字符
		System.out.println("[" + StringUtils.trimWhitespace(" 111 ") + "]");//去掉字符串中首尾的空白字符
		System.out.println("[" + StringUtils.trimAllWhitespace(" 1 1	 1  ") + "]");//去掉字符串中所有的空白字符
		System.out.println("[" + StringUtils.trimLeadingWhitespace(" 1 1	 1  ") + "]");//去掉字符串左边的空白字符
		System.out.println("[" + StringUtils.trimTrailingWhitespace(" 1 1	 1  ") + "]");//去掉字符串右边的空白字符
		System.out.println(StringUtils.startsWithIgnoreCase("grib.mb.2012.bat", "grib"));//判断字符串是否以xx开头，并且忽略大小写
		System.out.println(StringUtils.getFilename("D://aa/bb/a.txt"));//a.txt	获取文件名
		
		System.out.println(StringUtils.getFilenameExtension("D://aa/grib.mb.2012.bat"));//bat	获取文件扩展名
		System.out.println(StringUtils.stripFilenameExtension("grib.mb.2012.bat"));//grib.mb.2012	去掉文件扩展名
		
		System.out.println(StringUtils.replace(" 1 1	 1  ", "1", "#"));//替换字符串
		System.out.println(StringUtils.delete(" 1212qqqqq##", "q"));//从给定的字符串中删除所有匹配的字符
		System.out.println(StringUtils.deleteAny(" 1212qqqqq##", "1q"));// 22##	从给定的字符串中删除所有匹配的字符,
	}
}
