package cn.itcast.jdbc;

public class Person {
	private String pid;
	private String pname;
	private int age;
	private String gender;
	private int version;
	
	public Person(String pid, String pname, int age, String gender) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.age = age;
		this.gender = gender;
	}
	public Person(String pid, String pname, int age, String gender, int version) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.age = age;
		this.gender = gender;
		this.version = version;
	}
	public Person() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "Person [pid=" + pid + ", pname=" + pname + ", age=" + age
				+ ", gender=" + gender + "]";
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
}
