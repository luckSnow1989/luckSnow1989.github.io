package cn.itcast.usermng.dao;

import java.io.InputStream;
import java.util.Properties;

/**
 * 类工厂
 * @author 张雪
 *
 */
public class DaoFactory {
	/**
	 * 通过类，完成创建类对象！（反射完成的！）
	 * @param clazz
	 * @return
	 */
	public static <T> T  getBean(Class<T> clazz) {	
		String ClassName = clazz.toString().split(" ")[1];			
		Class clazz2 = null;
		try {
			clazz2 = Class.forName(ClassName);//得到想要类的反射
			return (T) clazz2.newInstance();//返回想要类的一个实例化
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
}
