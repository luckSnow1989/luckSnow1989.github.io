package com.webyun.datashare.hdfs.dao;


import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.ContentSummary;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.webyun.datashare.common.util.Assert;
import com.webyun.datashare.common.util.ConfigReaderUtil;

/**
 * @Project: dataShare
 * @Title: HdfsBaseDao
 * @Description: dfs文件系统基类
 * @author: zhangx
 * @date: 2017年7月24日 下午2:44:46
 * @company: webyun
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
@Repository
public class HdfsBaseDao {
	
	private final Logger loger = LoggerFactory.getLogger(HdfsBaseDao.class);  

	/**
	 * hadoop的环境变量
	 */
	private static String hadoopHomeEnv;
	
	/**
	 * hadoop文件系统的配置信息
	 */
	private static Configuration config;
	
	/**
	 * hadoop文件系统
	 */
	private FileSystem fileSystem;
	
	/*static {
		//初始化hadoop环境变量
		String defaultHadoopEnv = ConfigReaderUtil.get("hadoop.home.dir");
		String env = System.getProperty("hadoop.home.dir");
		hadoopHomeEnv = Assert.isEmpty(env) ? defaultHadoopEnv : env;
		System.setProperty("hadoop.home.dir", hadoopHomeEnv);
		
		//初始化hadoop配置
		config = new Configuration();
	}*/
	
	/*public HdfsBaseDao() {
		try {
			//初始化hadoop文件系统对象
			fileSystem = FileSystem.get(config);
		} catch (IOException e) {
			loger.error("hadoop文件配置异常");
			e.printStackTrace();
		}
	}*/
	/* *************************************工具方法************************************************/
	/**
	 * @Title: 下载文件到程序本地
	 * @param remote	hdfs路径
	 * @param local		本地路径
	 * @return
	 * @throws IOException
	 * @author: zhangx
	 * @date: 2017年7月24日 下午3:30:36
	 * @version v1.0
	 */
	public boolean downloadToLocal(String remote, String local) {
		FileSystem fs = this.getFileSystem();
		Path remotePath = new Path(remote);
		try {
			fs.copyToLocalFile(remotePath, new Path(local));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			this.close();
		}
	}
	
	/**
	 * @Title: 下载文件到指定的输出流中
	 * @param remote
	 * @param out
	 * @author: zhangx
	 * @date: 2017年7月24日 下午4:01:16
	 * @version v1.0
	 */
	public void downloadToOutputStream(String remote, OutputStream out) {
		FileSystem fs = this.getFileSystem();
		Path remotePath = new Path(remote);
		Configuration conf = HdfsBaseDao.getConfig();
		try ( FSDataInputStream in = fs.open(remotePath); ){//指定需要关闭的资源
			IOUtils.copyBytes(in, out, conf);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
	}
	/**
	 * @param localFile 	/docs/1400-8.txt
	 * @param hdfsFile 		hdfs://localhost/user/tom/1400-8.txt
	 */
	public boolean simpleUpLoad(String localFile, String hdfsFile) {
		Configuration conf = HdfsBaseDao.getConfig();
		try {
			InputStream in = new BufferedInputStream(new FileInputStream(localFile));
			FileSystem fs = FileSystem.get(URI.create(hdfsFile), conf);
			OutputStream out = fs.create(new Path(hdfsFile),
					new Progressable() {
						@Override
						public void progress() {
							System.out.print(".");
						}
					});
			
			IOUtils.copyBytes(in, out, 4096, true);
			IOUtils.closeStream(in);
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} finally {

		}
	}
	/**
	 * @Title: 创建文件夹
	 * @param dirUrl
	 * @return
	 * @author: zhangx
	 * @date: 2017年7月24日 下午4:04:07
	 * @version v1.0
	 */
	public boolean createDir(String dirUrl) {
		FileSystem fs = this.getFileSystem();
		Path dirPath = new Path(dirUrl);
		try {
			return fs.mkdirs(dirPath);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			this.close();
		}
	}
	
	/**
	 * @Title: 文件/文件夹重命名
	 * @param src
	 * @param dst
	 * @return
	 * @throws IOException
	 * @author: zhangx
	 * @date: 2017年7月24日 下午4:05:04
	 * @version v1.0
	 */
	public boolean rename(String src, String dst) throws IOException {
		FileSystem fs = this.getFileSystem();
		Path srcPath = new Path(src);
		Path dstPath = new Path(dst);
		try {
			return fs.rename(srcPath, dstPath);
		} catch (Exception e) {
			e.printStackTrace();
			this.close();
		}
		return false;
	}
	
	/**
	 * @Title: 删除文件或文件夹
	 * @param filePath
	 * @return
	 * @author: zhangx
	 * @date: 2017年7月24日 下午3:23:11
	 * @version v1.0
	 */
	public boolean deletePath(String filePath) {
		if(Assert.isEmpty(filePath)) {
			filePath = "/";
		}
		FileSystem fs = this.getFileSystem();
		Path path = new Path(filePath);
		
		try {
			fs.deleteOnExit(path);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return false;
	}
	
	/**
	 * 列出指定目录的所有文件和文件夹
	 * @param directory 指定的目录，根目录是"/"
	 * @return
	 */
	public List<FileStatus> doList(String directory) {
		if(Assert.isEmpty(directory)) {
			directory = "/";
		}
		
		FileSystem fs = this.getFileSystem();
		Path path = new Path(directory);
		
		List<FileStatus> list = new ArrayList<FileStatus>();

		try {
			FileStatus fileList[] = fs.listStatus(path);
			for (FileStatus fileStatues : fileList) {
				list.add(fileStatues);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return list;
	}

	/**
	 * 列出指定目录的所有文件
	 * @param directory 指定的目录
	 * @return
	 */
	public List<FileStatus> doListFile(String directory) {
		if(Assert.isEmpty(directory)) {
			directory = "/";
		}
		
		FileSystem fs = this.getFileSystem();
		Path path = new Path(directory);
		
		List<FileStatus> list = new ArrayList<FileStatus>();

		try {
			FileStatus fileList[] = fs.listStatus(path);
			for (FileStatus fileStatues : fileList) {
				if (!fileStatues.isDirectory()) {// 文件列表
					list.add(fileStatues);
					//System.out.println("the uri is:" + fileStatues.getPath().toUri());
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return list;
		
	}

	/**
	 * 列出指定目录的所有目录
	 * @param directory  指定的目录
	 * @return
	 */
	public List<FileStatus> doListDirectory(String directory) {
		if(Assert.isEmpty(directory)) {
			directory = "/";
		}
		
		FileSystem fs = this.getFileSystem();
		Path path = new Path(directory);
		
		List<FileStatus> list = new ArrayList<FileStatus>();

		try {
			FileStatus fileList[] = fs.listStatus(path);
			for (FileStatus fileStatues : fileList) {
				if (fileStatues.isDirectory()) {// 文件列表
					list.add(fileStatues);
					//System.out.println("the uri is:" + fileStatues.getPath().toUri());
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return list;
	}
	
	/**
	 * 获得路径下文件和文件夹的统计数据
	 * @param path 指定的文件/文件夹的路径
	 * @return
	 * @throws IOException
	 */
	public ContentSummary getContentSummary(String path){
		FileSystem fs = this.getFileSystem();
		Path filepath = new Path(path);
		try {
			ContentSummary contentSumary = fs.getContentSummary(filepath);
			return contentSumary;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return null;
//		System.out.println("getSpaceConsumed:" + contentSumary.getSpaceConsumed());
//		System.out.println("getDirectoryCount:" + contentSumary.getDirectoryCount());
//		System.out.println("getFileCount:" + contentSumary.getFileCount());
//		System.out.println("getSpaceQuota:" + contentSumary.getSpaceQuota());
//		System.out.println("getQuota:" + contentSumary.getQuota());
	}
	/**
	 * @Title: 文件是否已经存在
	 * @param filePath
	 * @return
	 * @author: zhangx
	 * @date: 2017年7月24日 下午4:30:56
	 * @version v1.0
	 */
	public boolean fileExists(String filePath) {
		boolean result = false;
		try {
			FileSystem fs = this.getFileSystem();
			result = fs.exists(new Path(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		return result;
	}
	/* *********************************************************************************************/
	
	public static String getHadoopHomeEnv() {
		return hadoopHomeEnv;
	}

	public static Configuration getConfig() {
		return config;
	}

	public FileSystem getFileSystem() {
		return fileSystem;
	}

	public void setFileSystem(FileSystem fileSystem) {
		this.fileSystem = fileSystem;
	}
	
	public void close(){
		try {
			fileSystem.close();
		} catch (IOException e) {
			loger.error("数据提交到hdfs异常");
			e.printStackTrace();
		}
	}
}
