package com.ssafy.ciot.model.dao;

import com.ssafy.ciot.model.dto.MealSchedule;

public interface MealDao {
	// 먹은 양 저장
	public int insertMeal(int catId, int mealAmount);
	
	// 스케줄 저장
	public int insertSchedule(MealSchedule mealSchedule);
}
