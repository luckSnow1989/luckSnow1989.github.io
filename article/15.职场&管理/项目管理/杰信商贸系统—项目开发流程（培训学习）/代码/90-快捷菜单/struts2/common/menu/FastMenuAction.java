package cn.itcast.web.struts2.common.menu;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.FastMenu;
import cn.itcast.entity.dao.FastMenuDAO;
import cn.itcast.web.struts2._BaseStruts2Action;

public class FastMenuAction extends _BaseStruts2Action implements ModelDriven<FastMenu> {
	private FastMenu model = new FastMenu();
	public FastMenu getModel() {
		return model;
	}	
	
	public void show() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String name = "";
		String curl = "";
		StringBuffer fastMenuBuf = new StringBuffer();
		
		FastMenuDAO fastMenuDao = (FastMenuDAO)this.getDao("daoFastMenu");
		String hql = "from FastMenu o where o.ctype='0' order by o.clickNum desc";	//快捷菜单
		List aList = fastMenuDao.find(hql);
		if(aList!=null){
			int i=0;i=0;
			if(aList.size()>0){
				for(i=0;i<aList.size();){
					FastMenu fastMenu = (FastMenu)aList.get(i);
					name = fastMenu.getCnname();
					curl =  fastMenu.getCurl();
					i++;
					fastMenuBuf.append("<div class=\"panel-content\">");
					fastMenuBuf.append("<ul><li><a href=\"").append(curl).append("\" target=\"main\" id=\"aa_6\" onclick=\"linkHighlighted(this);sndReqFind('").append(name).append("','").append(curl).append("')\">").append(name).append("</a>");
					fastMenuBuf.append("");
					fastMenuBuf.append("</li></ul></div>");
					if(i>4){
						break;	//只显示5条记录,
					}
				}
				fastMenuBuf.append("<a href=\"/common/fastMenuAction_delete\" class=\"DelFastMenu\"><font color=\"gray\">清除常用功能列表</font></a>");
			}else{
				fastMenuBuf.append("<div class=\"FastMenu\"><img src=\"../skin/default/images/notice.gif\" style=\"margin-right:5px;\" border=\"0\" /><font color=\"gray\">这里将自动列出常用的操作</font></div>");
			}
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");					//设定字符集，不然返回字符乱码
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(fastMenuBuf.toString());
		out.flush();
		out.close();
		
	}
	
	public void save() throws Exception{
		
		FastMenuDAO oDao = (FastMenuDAO)this.getDao("daoFastMenu");
		
		List aList = oDao.find("from FastMenu o where o.cnname='"+model.getCnname()+"' and o.curl='"+model.getCurl()+"' and o.ctype='0'");
		FastMenu fastMenu = null;
		if(aList==null || aList.size()==0){					//新增
			fastMenu = new FastMenu();
			fastMenu.setCnname(model.getCnname());
			fastMenu.setCurl(model.getCurl());
//			fastMenu.setBelongUser(userId);
			fastMenu.setClickNum(0);
			fastMenu.setCtype("0");	//0快捷菜单 1自定义菜单
		}else{												//修改
			fastMenu = (FastMenu)(aList.get(0));
			fastMenu.setClickNum(fastMenu.getClickNum()+1);	//浏览数增1
		}
		oDao.saveOrUpdate(fastMenu);

	}
	
	public String delete(){
		FastMenuDAO  oDao = (FastMenuDAO)super.getDao("daoFastMenu");
		List data = oDao.find("from FastMenu o where o.ctype='0'");
		if(data != null && data.size()>0){
			oDao.deleteAll(data);	//清除记录
		}
		

		//不返回东西,会成白页面 和struts1处理方式不同，变为ajax调用
		return SUCCESS;
	}
}
