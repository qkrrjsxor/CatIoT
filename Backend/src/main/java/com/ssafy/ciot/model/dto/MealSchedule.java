package com.ssafy.ciot.model.dto;

import java.time.LocalTime;

// 고양이별 자동 급여 스케쥴 시간 & 양
public class MealSchedule {
	private int scheduleId;
	private int catId;
	private LocalTime mealTime;	// 배급 시간
	private int mealScheduledAmount;	// 배급량
	
	public MealSchedule() {}

	public int getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public LocalTime getMealTime() {
		return mealTime;
	}

	public void setMealTime(LocalTime mealTime) {
		this.mealTime = mealTime;
	}

	public int getMealScheduledAmount() {
		return mealScheduledAmount;
	}

	public void setMealScheduledAmount(int mealScheduledAmount) {
		this.mealScheduledAmount = mealScheduledAmount;
	}
	
	
}
