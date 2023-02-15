package com.zx;

import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class MysqlShell {
	public static void main(String[] args) {
		backup();
	}
	/**
	 * 简单导出数据库
	 */
	public static void backup() {
		try {
			Runtime rt = Runtime.getRuntime();

			// 调用 MySQL 的 cmd:
			// 设置导出编码为utf8。这里必须是utf8
			Process child = rt.exec("C:/Program Files (x86)/MySQL/MySQL Server 5.1/bin/mysqldump -uroot -p4100107223  lovepandaj");

			// 把进程执行中的控制台输出信息写入.sql文件，即生成了备份文件。注：如果不对控制台信息进行读出，则会导致进程堵塞无法运行
			InputStream in = child.getInputStream();// 控制台的输出信息作为输入流

			InputStreamReader xx = new InputStreamReader(in, "utf8");// 设置输出流编码为utf8。这里必须是utf8，否则从流中读入的是乱码

			String inStr;
			StringBuffer sb = new StringBuffer("");
			String outStr;
			// 组合控制台输出信息字符串
			BufferedReader br = new BufferedReader(xx);
			while ((inStr = br.readLine()) != null) {
				sb.append(inStr + "\r\n");
			}
			outStr = sb.toString();

			// 要用来做导入用的sql目标文件：
			FileOutputStream fout = new FileOutputStream("d:/xytx.sql");
			OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8");
			writer.write(outStr);
			// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免
			writer.flush();

			// 别忘记关闭输入输出流
			in.close();
			xx.close();
			br.close();
			writer.close();
			fout.close();

			System.out.println("");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 导入数据库
	 */
	public static void load() {
		try {
			String fPath = "d:/xytx.sql";
			Runtime rt = Runtime.getRuntime();

			// 调用 mysql 的 cmd:
			Process child = rt.exec("C:/Program Files/MySQL/MySQL Server 5.0/bin/mysql.exe -uroot -proot xytx ");
			OutputStream out = child.getOutputStream();// 控制台的输入信息作为输出流
			String inStr;
			StringBuffer sb = new StringBuffer("");
			String outStr;
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fPath), "utf8"));
			while ((inStr = br.readLine()) != null) {
				sb.append(inStr + "\r\n");
			}
			outStr = sb.toString();

			OutputStreamWriter writer = new OutputStreamWriter(out, "utf8");
			writer.write(outStr);
			// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免
			writer.flush();
			// 别忘记关闭输入输出流
			out.close();
			br.close();
			writer.close();

			System.out.println("");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
