package cn.itcast.jdbc;

import java.sql.Array;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.NClob;
import java.sql.PreparedStatement;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.SQLXML;
import java.sql.Savepoint;
import java.sql.Statement;
import java.sql.Struct;
import java.util.Map;
import java.util.Properties;

import cn.itcast.jdbc.listener.CloseListener;

public class ItcastConnection implements Connection {
	private Connection baseConn;
	private CloseListener listener;
	private boolean isClose;
	private ItcastDataSource ids;
	
	public ItcastConnection(Connection baseConn) {
		this.baseConn = baseConn;
	}

	public Statement createStatement() throws SQLException {
		return baseConn.createStatement();
	}
	
	void setClose(boolean isClose) {
		this.isClose = isClose;
	}
	
	void setCloseListener(CloseListener closeListener) {
		this.listener = closeListener;
	}

	void setBaseConn(Connection baseConn) {
		this.baseConn = baseConn;
	}
	
	@Override
	public void close() throws SQLException {
		if(listener != null) {
			this.listener.run(this);
		}
		this.isClose = true;
	}

	@Override
	public boolean isClosed() throws SQLException {
		return isClose;
	}

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return baseConn.unwrap(iface);
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		return baseConn.isWrapperFor(iface);
	}

	@Override
	public PreparedStatement prepareStatement(String sql) throws SQLException {
		return baseConn.prepareStatement(sql);
	}

	@Override
	public CallableStatement prepareCall(String sql) throws SQLException {
		return baseConn.prepareCall(sql);
	}

	@Override
	public String nativeSQL(String sql) throws SQLException {
		return baseConn.nativeSQL(sql);
	}

	@Override
	public void setAutoCommit(boolean autoCommit) throws SQLException {
		baseConn.setAutoCommit(autoCommit);
	}

	@Override
	public boolean getAutoCommit() throws SQLException {
		return baseConn.getAutoCommit();
	}

	@Override
	public void commit() throws SQLException {
		baseConn.commit();
	}

	@Override
	public void rollback() throws SQLException {
		baseConn.rollback();
	}


	@Override
	public DatabaseMetaData getMetaData() throws SQLException {
		return baseConn.getMetaData();
	}

	@Override
	public void setReadOnly(boolean readOnly) throws SQLException {
		baseConn.setReadOnly(readOnly);
	}

	@Override
	public boolean isReadOnly() throws SQLException {
		return baseConn.isReadOnly();
	}

	@Override
	public void setCatalog(String catalog) throws SQLException {	
		baseConn.setCatalog(catalog);
	}

	@Override
	public String getCatalog() throws SQLException {
		return baseConn.getCatalog();
	}

	@Override
	public void setTransactionIsolation(int level) throws SQLException {
		baseConn.setTransactionIsolation(level);
	}

	@Override
	public int getTransactionIsolation() throws SQLException {
		return baseConn.getTransactionIsolation();
	}

	@Override
	public SQLWarning getWarnings() throws SQLException {
		return baseConn.getWarnings();
	}

	@Override
	public void clearWarnings() throws SQLException {
		baseConn.clearWarnings();
	}

	@Override
	public Statement createStatement(int resultSetType, int resultSetConcurrency)
			throws SQLException {
		return baseConn.createStatement(resultSetType, resultSetConcurrency);
	}

	@Override
	public PreparedStatement prepareStatement(String sql, int resultSetType,
			int resultSetConcurrency) throws SQLException {
		return baseConn.prepareStatement(sql, resultSetType, resultSetConcurrency);
	}

	@Override
	public CallableStatement prepareCall(String sql, int resultSetType,
			int resultSetConcurrency) throws SQLException {
		return baseConn.prepareCall(sql, resultSetType, resultSetConcurrency);
	}

	@Override
	public Map<String, Class<?>> getTypeMap() throws SQLException {
		return baseConn.getTypeMap();
	}

	@Override
	public void setTypeMap(Map<String, Class<?>> map) throws SQLException {
		baseConn.setTypeMap(map);
	}

	@Override
	public void setHoldability(int holdability) throws SQLException {
		baseConn.setHoldability(holdability);
	}

	@Override
	public int getHoldability() throws SQLException {
		return baseConn.getHoldability();
	}

	@Override
	public Savepoint setSavepoint() throws SQLException {
		return baseConn.setSavepoint();
	}

	@Override
	public Savepoint setSavepoint(String name) throws SQLException {
		return baseConn.setSavepoint(name);
	}

	@Override
	public void rollback(Savepoint savepoint) throws SQLException {
		baseConn.rollback(savepoint);
	}

	@Override
	public void releaseSavepoint(Savepoint savepoint) throws SQLException {
		baseConn.releaseSavepoint(savepoint);
	}

	@Override
	public Statement createStatement(int resultSetType,
			int resultSetConcurrency, int resultSetHoldability)
			throws SQLException {
		return baseConn.createStatement(resultSetType, resultSetConcurrency, resultSetHoldability);
	}

	@Override
	public PreparedStatement prepareStatement(String sql, int resultSetType,
			int resultSetConcurrency, int resultSetHoldability)
			throws SQLException {
		return baseConn.prepareStatement(sql, resultSetType, resultSetConcurrency, resultSetHoldability);
	}

	@Override
	public CallableStatement prepareCall(String sql, int resultSetType,
			int resultSetConcurrency, int resultSetHoldability)
			throws SQLException {
		return baseConn.prepareCall(sql, resultSetType, resultSetConcurrency, resultSetHoldability);
	}

	@Override
	public PreparedStatement prepareStatement(String sql, int autoGeneratedKeys)
			throws SQLException {
		return baseConn.prepareStatement(sql, autoGeneratedKeys);
	}

	@Override
	public PreparedStatement prepareStatement(String sql, int[] columnIndexes)
			throws SQLException {
		return baseConn.prepareStatement(sql, columnIndexes);
	}

	@Override
	public PreparedStatement prepareStatement(String sql, String[] columnNames)
			throws SQLException {
		return baseConn.prepareStatement(sql, columnNames);
	}

	@Override
	public Clob createClob() throws SQLException {
		return baseConn.createClob();
	}

	@Override
	public Blob createBlob() throws SQLException {
		return baseConn.createBlob();
	}

	@Override
	public NClob createNClob() throws SQLException {
		return baseConn.createNClob();
	}

	@Override
	public SQLXML createSQLXML() throws SQLException {
		return baseConn.createSQLXML();
	}

	@Override
	public boolean isValid(int timeout) throws SQLException {
		return baseConn.isValid(timeout);
	}

	@Override
	public void setClientInfo(String name, String value)
			throws SQLClientInfoException {
		baseConn.setClientInfo(name, value);
	}

	@Override
	public void setClientInfo(Properties properties)
			throws SQLClientInfoException {
		baseConn.setClientInfo(properties);
	}

	@Override
	public String getClientInfo(String name) throws SQLException {
		return baseConn.getClientInfo(name);
	}

	@Override
	public Properties getClientInfo() throws SQLException {
		return baseConn.getClientInfo();
	}

	@Override
	public Array createArrayOf(String typeName, Object[] elements)
			throws SQLException {
		return baseConn.createArrayOf(typeName, elements);
	}

	@Override
	public Struct createStruct(String typeName, Object[] attributes)
			throws SQLException {
		return baseConn.createStruct(typeName, attributes);
	}
}
