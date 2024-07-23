package com.ssafy.ciot.model.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

// 날짜별 먹은 양을 저장하는 dto
public class MealEaten {
	private int mealId;
	private int catId;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime mealDate;	// 날짜
	private int mealAmount;	// 먹은 양
	
	
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
	public int getMealAmount() {
		return mealAmount;
	}
	public void setMealAmount(int mealAmount) {
		this.mealAmount = mealAmount;
	}
}
