package com.ssafy.ciot.model.dto;

import java.time.LocalDateTime;

// 날짜별 먹은 양을 저장하는 dto
public class MealEaten {
	private int mealId;
	private int catId;
	private LocalDateTime mealDate;	// 날짜
	private int mealEatenAmount;	// 먹은 양
	
	
	public int getMealId() {
		return mealId;
	}
	public void setMealId(int mealId) {
		this.mealId = mealId;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public LocalDateTime getMealDate() {
		return mealDate;
	}
	public void setMealDate(LocalDateTime mealDate) {
		this.mealDate = mealDate;
	}
	public int getMealEatenAmount() {
		return mealEatenAmount;
	}
	public void setMealEatenAmount(int mealEatenAmount) {
		this.mealEatenAmount = mealEatenAmount;
	}
}
