package cn.itcast.domain;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import cn.itcast.service.UserService;
import cn.itcast.service.impl.UserServiceImpl;
import cn.itcast.util.WebUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class User extends ActionSupport implements Serializable {
	
	private String id;//����
	private String username;//��¼��
	private String nick;//�ǳ�
	private String password;//MD5����
	private String sex;//0 Ů 1��
	private Date birthday;//��������2010-10-09
	private String education;//ѧ�����о���   ���� ר�� ���� ��ר �׶�԰
	private String telephone;//�绰
	private String[] hobbies;//���⡣   ���� ��Ӿ
	private String hobby;//����,��Ӿ
	private String path;//�ļ������·��
	private String filename;//����ļ���   UUID_���ļ���
	private String remark;//���
	
	//�ļ��ϴ��Ķ���
	private File image;
	private String imageFileName;
	private String imageContentType;
	
	//�ļ�����
	private InputStream inputStream;
	
	
	
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String[] getHobbies() {
		return hobbies;
	}
	public void setHobbies(String[] hobbies) {
		this.hobbies = hobbies;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public File getImage() {
		return image;
	}
	public void setImage(File image) {
		this.image = image;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getImageContentType() {
		return imageContentType;
	}
	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}
	
	@Override
	public String toString() {
		return "User [birthday=" + birthday + ", education=" + education
				+ ", filename=" + filename + ", hobbies="
				+ Arrays.toString(hobbies) + ", hobby=" + hobby + ", id=" + id
				+ ", image=" + image + ", imageContentType=" + imageContentType
				+ ", imageFileName=" + imageFileName + ", nick=" + nick
				+ ", password=" + password + ", path=" + path + ", remark="
				+ remark + ", s=" + s + ", sex=" + sex + ", telephone="
				+ telephone + ", username=" + username + "]";
	}

	private UserService s = new UserServiceImpl();
	public String listUsers(){
		List<User> users = s.findAllUsers();
		ActionContext.getContext().put("users", users);// #users
		return SUCCESS;
	}
	public String editUser(){
		//��������hobby
		if(hobbies!=null&&hobbies.length>0){
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<hobbies.length;i++){
				if(i>0)
					sb.append(",");
				sb.append(hobbies[i]);
			}
			hobby = sb.toString();
		}
		
		//��������path��filename
		filename = UUID.randomUUID().toString()+"_"+imageFileName;
		//�õ�files���Ŀ¼����ʵ·��
		String storePath = ServletActionContext.getServletContext().getRealPath("/files");
		//�����ŵ���·��
		path = WebUtil.makeDirs(storePath,filename);
		
		
		//�ļ��ϴ�
		
		try {
			FileUtils.copyFile(image, new File(storePath+"\\"+path+"\\"+filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		s.updateUser(this);
		ActionContext.getContext().put("message", "�޸ĳɹ���");
		return "editOk";
	}
	public String addUser(){
		System.out.println(this);
		//��������hobby
		if(hobbies!=null&&hobbies.length>0){
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<hobbies.length;i++){
				if(i>0)
					sb.append(",");
				sb.append(hobbies[i]);
			}
			hobby = sb.toString();
		}
		
		//��������path��filename
		filename = UUID.randomUUID().toString()+"_"+imageFileName;
		//�õ�files���Ŀ¼����ʵ·��
		String storePath = ServletActionContext.getServletContext().getRealPath("/files");
		//�����ŵ���·��
		path = WebUtil.makeDirs(storePath,filename);
		
		
		//�ļ��ϴ�
		
		try {
			FileUtils.copyFile(image, new File(storePath+"\\"+path+"\\"+filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		s.addUser(this);
		ActionContext.getContext().put("message", "����ɹ���");
		return "saveOk";
	}
	public String queryCondition(){
		List<User> users =s.findUserByCondition(this);
		ActionContext.getContext().put("users", users);// #users
		return SUCCESS;
	}
	public String delUser(){
		String userId = ServletActionContext.getRequest().getParameter("userId");
		s.delUser(userId);
		return "delOk";
	}
	public String editUserUI(){
		String userId = ServletActionContext.getRequest().getParameter("userId");
		User user = s.findUserById(userId);
		user.setHobbies(user.getHobby().split(","));
		ActionContext.getContext().put("user", user);
		return "editUI";
	}
	public String showUser(){
		String userId = ServletActionContext.getRequest().getParameter("userId");
		User user = s.findUserById(userId);
		ActionContext.getContext().put("user", user);
		return "showUser";
	}
	public String download(){
		path = ServletActionContext.getRequest().getParameter("path");
		filename = ServletActionContext.getRequest().getParameter("filename");
		
		String storePath = ServletActionContext.getServletContext().getRealPath("/files");
		
		try {
			inputStream = new FileInputStream(storePath+"\\"+path+"\\"+filename);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	public String login(){
		User user = s.login(username,password);
		if(user==null){
			return LOGIN;
		}else{
			ServletActionContext.getRequest().getSession().setAttribute("user", user);
			return SUCCESS;
		}
	}
}
