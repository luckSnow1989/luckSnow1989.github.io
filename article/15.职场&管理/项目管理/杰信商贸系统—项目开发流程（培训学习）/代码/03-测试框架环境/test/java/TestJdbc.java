package test.java;
import java.sql.*;

import org.junit.Test;

public class TestJdbc {

	public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		TestJdbc tj = new TestJdbc();
		tj.jdbcex(true);
	}
	
	//@Test
	public void testNoClose() throws Exception{
		for(int i=1;i<=10000;i++){
			System.out.println("--"+i+"--");
			jdbcex(false);
		}
	}
	
	//@Test
	public void testClose() throws Exception{
		for(int i=1;i<=10000;i++){
			System.out.println("--"+i+"--");
			jdbcex(true);
		}
	}	

	public void jdbcex(boolean isClose) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver").newInstance();  
		
		String url = "jdbc:mysql://localhost:3306/itcastjkdb?characterEncoding=UTF-8";
		String user = "root";
		String password = "root";
		
		Connection conn = DriverManager.getConnection(url, user,password);   
		Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);   

		String sql = "select * from test_table_c";   
		ResultSet rs = stmt.executeQuery(sql);  
		ResultSetMetaData rsmd = rs.getMetaData();

		//column name
		StringBuffer sBuf = new StringBuffer();
		for(int i=1;i<=rsmd.getColumnCount();i++){
			sBuf.append(rsmd.getColumnLabel(i))
			.append(":")
			.append(rsmd.getColumnTypeName(i))
			.append("(")
			.append(rsmd.getColumnDisplaySize(i))
			.append(") | ");
		}
		
		System.out.println(sBuf.toString());
		
		//context
		int j = 0;
		while(rs.next()) {
			j++;
			sBuf.delete(0, sBuf.length());		//clear
			for(int i=1;i<=rsmd.getColumnCount();i++){
				sBuf.append(rs.getString(i)).append(") | ");
			}
			System.out.println(sBuf.toString());
		}
		
		System.out.println("Totals:"+String.valueOf(j));
		
		if(isClose){
			this.close(rs, stmt, conn);
		}
	}
	
	//close resource
	private void close(ResultSet rs, Statement stmt, Connection conn ) throws SQLException{
		rs.close();   
		stmt.close();   
		conn.close(); 
	}
}
