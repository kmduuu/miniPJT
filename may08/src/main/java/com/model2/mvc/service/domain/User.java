package com.model2.mvc.service.domain;

import java.sql.Date;


//==>회원정보를 모델링(추상화/캡슐화)한 Bean
public class User {
	
	///Field
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	private String phone;
	private String addr;
	private String email;
	private Date regDate;
	//////////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	private String regDateString;

	
	
	///Constructor
	public User(){
	}
	
	///Method 
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		System.out.println(addr+"하하하하 한글깨진당");
		return addr;
	}
	public void setAddr(String addr) {
		System.out.println(addr+"하하하하 한글 또 깨지는 고마잉");
		this.addr = addr;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegDate() {
		return regDate;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
		
		if(regDate !=null) {
			// JSON ==> Domain Object  Binding을 위해 추가된 부분
			this.setRegDateString( regDate.toString().split("-")[0]
													+"-"+ regDate.toString().split("-")[1]
													+ "-" +regDate.toString().split("-")[2] );
		}
		
	}

	@Override
	public String toString() {
		return "UserVO : [userId] "+userId+" [userName] "+userName+" [password] "+password+" [role] "+ role
			+" [ssn] "+ssn+" [phone] "+phone+" [email] "+email+" [regDate] "+regDate+" [addr]" + addr ;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	// POJO 의 중요성
	/////////////////////////////////////////////////////////////////////////////////////////

	public String getRegDateString() {
		return regDateString;
	}

	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}
}
