package com.ssafy.ciot.model.service;

import org.springframework.stereotype.Service;

import com.ssafy.ciot.model.dao.MealDao;

@Service
public class MealService {
	
	// dao 의존성
	private MealDao mealDao;
	public MealService (MealDao mealDao) {
		this.mealDao = mealDao;
	}
	
	// 수동 배급
	public void manualFeed(int catId, int amount) {
		
	}
}
