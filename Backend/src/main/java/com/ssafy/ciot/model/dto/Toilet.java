package com.ssafy.ciot.model.dto;

import java.time.LocalDateTime;

public class Toilet {
	private int toiletId;
	private int catId;
	private LocalDateTime toiletTime;
	private String toiletType;	// enum - pee/poo
	
	public Toilet () {}

	public int getToiletId() {
		return toiletId;
	}

	public void setToiletId(int toiletId) {
		this.toiletId = toiletId;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public LocalDateTime getToiletTime() {
		return toiletTime;
	}

	public void setToiletTime(LocalDateTime toiletTime) {
		this.toiletTime = toiletTime;
	}

	public String getToiletType() {
		return toiletType;
	}

	public void setToiletType(String toiletType) {
		this.toiletType = toiletType;
	}
	
	
}
