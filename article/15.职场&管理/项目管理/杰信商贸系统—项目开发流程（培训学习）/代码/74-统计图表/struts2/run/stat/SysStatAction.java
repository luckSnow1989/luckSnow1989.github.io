package cn.itcast.web.struts2.run.stat;

import java.io.FileNotFoundException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.itcast.common.springdao.AppContext;
import cn.itcast.common.springdao.SQLDAO;
import cn.itcast.entity.dao._RootDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.struts2._BaseStruts2Action;

public class SysStatAction extends _BaseStruts2Action {
	
	//厂家销售情况统计
	public String factorySale() throws FileNotFoundException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String sql = "SELECT f.factory_name, p.conutnum FROM (SELECT factory_id,COUNT(*) AS conutnum FROM ext_cproduct_c GROUP BY factory_id) p LEFT JOIN (SELECT factory_id,factory_name FROM factory_c) f ON p.factory_id=f.factory_id";
		SQLDAO sqlDAO = (SQLDAO)AppContext.getInstance().getAppContext().getBean("sqlDao");
		
		List<String> statInfo = sqlDAO.executeSQL(sql);
		this.factorySaleMake(statInfo);
		
		request.setAttribute("statInfo",statInfo);
		return "factorysale";
	}
	public void factorySaleMake(List<String> statData) throws FileNotFoundException{
		FileUtil fu = new FileUtil();
		StringBuffer sBuf = new StringBuffer();
		
		sBuf.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>").append(UtilFuns.newLine());
		sBuf.append("<pie>").append(UtilFuns.newLine());
		
		for(int i=0;i<statData.size();){
			sBuf.append("		<slice title=\"").append(statData.get(i++)).append("\">").append(statData.get(i++)).append("</slice>").append(UtilFuns.newLine());
		}
		sBuf.append("</pie>");
		
		fu.newTxt(UtilFuns.getROOTPath(), "run\\stat\\factorysale\\ampie_data.xml", sBuf.toString(), "UTF-8");		//文件格式必须是UTF-8		
	}	
	
	//产品销售排行
	public String productSale() throws FileNotFoundException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String sql = "SELECT product_no,COUNT(*) FROM export_product_c GROUP BY product_no ORDER BY COUNT(*) DESC LIMIT 10";
		SQLDAO sqlDAO = (SQLDAO)AppContext.getInstance().getAppContext().getBean("sqlDao");
		
		List<String> statInfo = sqlDAO.executeSQL(sql);
		this.productSaleXmlMake(statInfo);
	
		request.setAttribute("statInfo",statInfo);
		return "productsale";
	}
	public void productSaleXmlMake(List<String> statData) throws FileNotFoundException{
		FileUtil fu = new FileUtil();
		StringBuffer sBuf = new StringBuffer();
		int rownum = 0;
		
		sBuf.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>").append(System.getProperty("line.separator"));
		sBuf.append("<chart>").append(System.getProperty("line.separator"));
		sBuf.append("	<series>").append(System.getProperty("line.separator"));
		
		rownum = 0;
		for(int i=0;i<statData.size();){
			sBuf.append("		<value xid=\"").append(rownum++).append("\"><![CDATA[").append(UtilFuns.convertNull(statData.get(i++))).append("]]></value>").append(System.getProperty("line.separator"));
			i++;	//skip
		}
		
		sBuf.append("	</series>").append(System.getProperty("line.separator"));
		sBuf.append("	<graphs>").append(System.getProperty("line.separator"));
		sBuf.append("		<graph gid=\"30\" color=\"#FFCC00\" gradient_fill_colors=\"#111111, #1A897C\">").append(System.getProperty("line.separator"));
		
		rownum = 0;
		for(int i=0;i<statData.size();){
			i++;	//skip
			sBuf.append("			<value xid=\"").append(rownum++).append("\"  description=\"\" url=\"\">").append(statData.get(i++)).append("</value>").append(System.getProperty("line.separator"));
		}
		
		sBuf.append("		</graph>").append(System.getProperty("line.separator"));
		sBuf.append("	</graphs>").append(System.getProperty("line.separator"));
		
		sBuf.append("  <labels>").append(System.getProperty("line.separator"));
		sBuf.append("    <label lid=\"0\">").append(System.getProperty("line.separator"));
		sBuf.append("      <x>0</x>").append(System.getProperty("line.separator"));
		sBuf.append("      <y>20</y>").append(System.getProperty("line.separator"));
		sBuf.append("      <rotate></rotate>").append(System.getProperty("line.separator"));
		sBuf.append("      <width></width>").append(System.getProperty("line.separator"));
		sBuf.append("      <align>center</align>").append(System.getProperty("line.separator"));
		sBuf.append("      <text_color></text_color>").append(System.getProperty("line.separator"));
		sBuf.append("      <text_size></text_size>").append(System.getProperty("line.separator"));
		sBuf.append("      <text>").append(System.getProperty("line.separator"));
		sBuf.append("        <![CDATA[]>").append(System.getProperty("line.separator"));	//标题 默认设置为空
		sBuf.append("      </text>").append(System.getProperty("line.separator"));
		sBuf.append("    </label>").append(System.getProperty("line.separator"));
		sBuf.append("  </labels>").append(System.getProperty("line.separator"));
		
		sBuf.append("</chart>");
		
		fu.newTxt(UtilFuns.getROOTPath(), "run\\stat\\productsale\\amcolumn_data1.xml", sBuf.toString(), "UTF-8");		//文件格式必须是UTF-8		
	}
	
	//系统访问压力图
	public String onlineinfo() throws FileNotFoundException{
		HttpServletRequest request = ServletActionContext.getRequest();
		SQLDAO sqlDAO = (SQLDAO)AppContext.getInstance().getAppContext().getBean("sqlDao");
		
		_RootDAO rDao = (_RootDAO)this.getDao("daoRoot");
		
		String sql = null;
		List dateList = null;
		String maxDate = null;
		
		//奇异现象spring2+sqlserver2000下面语句执行正常 spring3+mysql5执行，获得第一个字段值为对象 	by tony
		//变相解决，构造临时表，动态插入数据，然后从临时表中获取数据
		sql = "DELETE FROM onlineinfo_t";		//清空数据
		sqlDAO.updateSQL(sql);
		
		sql = "insert into onlineinfo_t SELECT SUBSTRING(login_time,12,2),COUNT(*) FROM LOGIN_LOG_P GROUP BY SUBSTRING(login_time,12,2) ORDER BY SUBSTRING(login_time,12,2)";
		sqlDAO.updateSQL(sql);					//批量插入数据
		
		sql = "SELECT a1,a2 from onlineinfo_t ORDER BY a1";
		List<String> statInfo = sqlDAO.executeSQL(sql);
		
		FileUtil fu = new FileUtil();
		StringBuffer sBuf = new StringBuffer();
		int rownum = 0;
		int j = 0;
		int k = 0;
		
		sBuf.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>").append(System.getProperty("line.separator"));
		sBuf.append("<chart>").append(System.getProperty("line.separator"));
		sBuf.append("	<series>").append(System.getProperty("line.separator"));
		
		for(j=0;j<24;j++){
			sBuf.append("		<value xid=\"").append(rownum++).append("\">").append(j).append("</value>").append(System.getProperty("line.separator"));
		}
		sBuf.append("	</series>").append(System.getProperty("line.separator"));
		sBuf.append("	<graphs>").append(System.getProperty("line.separator"));
		sBuf.append("		<graph color=\"#00CC00\" title=\"\">").append(System.getProperty("line.separator"));
		
		rownum = 0;
		for(j=0;j<24;j++){
			for(;k<statInfo.size();){
				if(j == new Integer(statInfo.get(k)) ){
					k++;
					sBuf.append("			<value xid=\"").append(rownum++).append("\">").append(statInfo.get(k++)).append("</value>").append(System.getProperty("line.separator"));
				}else{
					sBuf.append("			<value xid=\"").append(rownum++).append("\">").append(0).append("</value>").append(System.getProperty("line.separator"));
				}
				break;
			}
		}				
		sBuf.append("		</graph>").append(System.getProperty("line.separator"));
		sBuf.append("	</graphs>").append(System.getProperty("line.separator"));
		sBuf.append("</chart>");

		fu.newTxt(UtilFuns.getROOTPath(), "run\\stat\\onlineinfo\\amline_data1.xml", sBuf.toString(), "UTF-8");		//文件格式必须是UTF-8
		request.setAttribute("statInfo",statInfo);
		//1-------end

		
		return "onlineinfo";
	}

}