package com.ssafy.ciot.model.service;

import org.springframework.stereotype.Service;

import com.ssafy.ciot.model.dao.MealDao;
import com.ssafy.ciot.model.dto.MealEaten;
import com.ssafy.ciot.model.dto.MealSchedule;

@Service
public class MealService {
	
	// dao 의존성
	private MealDao mealDao;
	public MealService (MealDao mealDao) {
		this.mealDao = mealDao;
	}
	
	// 수동 배급
	public void manualFeed(int catId, int mealAmount) {
		
	}
	
	// 자동 배급 스케줄 저장
	public int insertSchedule(MealSchedule mealSchedule) {
		return mealDao.insertSchedule(mealSchedule);
	}
	
	// 먹은 양 저장
	public int insertMeal(MealEaten mealEaten) {
		return mealDao.insertMeal(mealEaten);
	}
}
