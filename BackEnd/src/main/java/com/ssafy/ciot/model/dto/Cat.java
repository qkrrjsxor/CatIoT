package com.ssafy.ciot.model.dto;

public class Cat {
	private int catId;
	private String userId;
	private String catName;
	private int catAge;
	private String catGender; // enum - female/male
		
	public Cat() {}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public int getCatAge() {
		return catAge;
	}

	public void setCatAge(int catAge) {
		this.catAge = catAge;
	}

	public String getCatGender() {
		return catGender;
	}

	public void setCatGender(String catGender) {
		this.catGender = catGender;
	}
	
	
}
