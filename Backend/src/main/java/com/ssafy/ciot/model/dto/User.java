package com.ssafy.ciot.model.dto;


public class User {

	private String userId;
	private String password;
	private String userName;
	
	public User() {}
	
	public User(String userId, String password, String userName) {
		this.userId = userId;
		this.password = password;
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
