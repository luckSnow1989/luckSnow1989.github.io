package com.webyun.datashare.hdfs.controller;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.webyun.datashare.hdfs.dao.HdfsBaseDao;

@Controller
@RequestMapping("/hdfs")
public class HdfsController {

	@Autowired
	private HdfsBaseDao hdfsBaseDao;
	
	@RequestMapping("/data.app")
	@ResponseBody
	public void download(HttpServletRequest request, HttpServletResponse response){
		try {
			OutputStream output = response.getOutputStream();
			//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型   
	        response.setContentType("multipart/form-data");   
	        //2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)   
	        response.setHeader("Content-Disposition", "attachment;fileName=demo.txt");  
			
	        //从hdfs中读取文件
	        //this.hdfsBaseDao.downloadToOutputStream("/in/demo.txt", out);
	        
	        //测试文件
			FileInputStream input = new FileInputStream("D://b.txt");
			
			IOUtils.copy(input, output);
			
			// 关闭资源
			IOUtils.closeQuietly(input);
			IOUtils.closeQuietly(output);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
