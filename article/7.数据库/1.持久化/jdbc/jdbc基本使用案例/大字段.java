package cn.itcast.demo4;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialBlob;

import org.apache.commons.io.IOUtils;
import org.junit.Test;

import cn.itcast.demo3.JdbcUtils;

/**
 * 大数据
 * @author zx
 * 
 * MySQL存储blob数据包太大:
 * com.mysql.jdbc.PacketTooBigException: Packet for query is too large (9802817 > 1048576). You can change this  * value on the server 
	by setting the max_allowed_packet' variable.
 * 在my.ini中设置，在[mysqld]下添加max_allowed_packet=10M，例如：
 * [mysqld] 
 * max_allowed_packet=64M
 */
public class Demo4 {
	/**
	 * 把mp3保存到数据库中。
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	@Test
	public void fun1() throws Exception {
		/*
		 * 1. 得到Connection
		 * 2. 给出sql模板，创建ps
		 * 3. 设置sql模板中的参数
		 * 4. 调用ps的executeUpdate()执行
		 */
		Connection con = JdbcUtils.getConnection();
		String sql = "insert into tab_bin values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, 1);
		ps.setString(2, "流光飞舞.mp3");
		/**
		 * 需要得到Blob
		 * 1. 我们有的是文件，目标是Blob
		 * 2. 先把文件变成byte[]
		 * 3. 再使用byte[]创建Blob
		 */
		// 把文件转换成byte[]
		byte[] bytes = IOUtils.toByteArray(new FileInputStream("F:/流光飞舞.mp3"));
		// 使用byte[]创建Blob
		Blob blob = new SerialBlob(bytes);
		// 设置参数
		ps.setBlob(3, blob);
		
		ps.executeUpdate();
	}
	
	/**
	 * 从数据库读取mp3
	 * @throws SQLException 
	 */
	@Test
	public void fun2() throws Exception {
		/*
		 * 1. 创建Connection
		 */
		Connection con = JdbcUtils.getConnection();
		/*
		 * 2. 给出select语句模板，创建ps
		 */
		String sql = "select * from tab_bin";
		PreparedStatement ps = con.prepareStatement(sql);
		
		/*
		 * 3. ps执行查询，得到ResultSet
		 */
		ResultSet rs = ps.executeQuery();
		
		/*
		 * 4. 获取rs中名为data的列数据
		 */
		if(rs.next()) {
			Blob blob = rs.getBlob("data");
			/*
			 * 把Blob变成硬盘上的文件！
			 */
			/*
			 * 1. 通过Blob得到输入流对象
			 * 2. 自己创建输出流对象
			 * 3. 把输入流的数据写入到输出流中
			 */
			InputStream in = blob.getBinaryStream();
			OutputStream out = new FileOutputStream("c:/lgfw.mp3");
			IOUtils.copy(in, out);
		}
	}
}
