package com.ssafy.ciot.model.dto;

import java.time.LocalDateTime;

// 날짜별 급여 양 저장하는 dto
public class MealFeed {
	private int feedId;
	private int catId;
	private LocalDateTime feedDate;	// 날짜
	private int feedAmount;
	
	
	public int getFeedId() {
		return feedId;
	}
	public void setFeedId(int feedId) {
		this.feedId = feedId;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public LocalDateTime getFeedDate() {
		return feedDate;
	}
	public void setFeedDate(LocalDateTime feedDate) {
		this.feedDate = feedDate;
	}
	public int getFeedAmount() {
		return feedAmount;
	}
	public void setFeedAmount(int feedAmount) {
		this.feedAmount = feedAmount;
	}	
	
	
}
