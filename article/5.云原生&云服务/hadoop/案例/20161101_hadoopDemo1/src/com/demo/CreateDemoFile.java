package com.demo;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;

public class CreateDemoFile {
	
	public void demo1(){
		String[] Rphone = {"10086","15030518550","15130518551","15330518553","1613051854","17130518551","13630518555"
				,"17130518529","1603051855151","15030518556","14030518553","15730518660"};
		int len = Rphone.length;
		FileOutputStream os = null;
		try {
			os = new FileOutputStream("D:/phone.log");
			byte[] b = new byte[1024];
			
			Random r1 = new Random(System.currentTimeMillis());
			Random r2 = new Random(System.currentTimeMillis() - 10000l);
			for (int i = 0; i < 10000; i++) {
				int index1 = r1.nextInt(len);
				int index2 = r2.nextInt(len);
				if(index1 != index2) {
					b = (Rphone[index1] + " " + Rphone[index2] + "\r\n").getBytes();
					os.write(b, 0, b.length);
				}
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public static void newFile(String text, String filePath){
		FileOutputStream os = null;
		try {
			byte[] b = text.getBytes();
			os = new FileOutputStream(filePath);
			os.write(b);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		//newFile("dashdgasudg\r\nsdhash", "D://aa.txt");
		//new CreateDemoFile().demo1();
		System.out.println(6666);
	}
}
