package cn.itcast.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.Test;

/**
 * 并发事务问题之丢失更新
 * 
 * @author Administrator
 * 
 */
public class Demo1 {
	private static Connection getConnection() throws Exception {
		String driverClassName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/day12?useUnicode=true&characterEncoding=utf8";
		String username = "root";
		String password = "123";

		Class.forName(driverClassName);
		return DriverManager.getConnection(url, username, password);
	}

	public Person load(Connection con, String pid) throws Exception {
		String sql = "select * from t_person where pid=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, pid);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			return new Person(rs.getString(1), rs.getString(2), rs.getInt(3),
					rs.getString(4), rs.getInt(5));
		}
		return null;
	}
	
	public void update(Connection con, Person p) throws Exception {
		String sql = "update t_person set pname=?, age=?, gender=? where pid=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, p.getPname());
		pstmt.setInt(2, p.getAge());
		pstmt.setString(3, p.getGender());
		pstmt.setString(4, p.getPid());
		pstmt.setInt(5, p.getVersion());
		
		pstmt.executeUpdate();
	}
	
	@Test
	public void fun1() throws Exception {
		Connection con = getConnection();
		con.setAutoCommit(false);
		
		Person p = load(con, "p1");
		p.setAge(42);
		update(con, p);
		
		con.commit();
	}
	
	@Test
	public void fun2() throws Exception {
		Connection con = getConnection();
		con.setAutoCommit(false);
		
		Person p = load(con, "p1");
		p.setGender("female");
		update(con, p);
		
		con.commit();
	}
}
