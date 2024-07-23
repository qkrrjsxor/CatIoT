package com.ssafy.ciot.model.service;

import java.time.LocalDateTime;

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
	
	// 배급 내역 저장
	public int insertFeed(int catId, LocalDateTime mealDate, int mealAmount) {
		return mealDao.insertFeed(catId, mealDate, mealAmount);
	}
	
	// 자동 배급 스케줄 저장
	public int insertSchedule(MealSchedule mealSchedule) {
		return mealDao.insertSchedule(mealSchedule);
	}
	
	// 자동 배급 스케줄 업데이트
	public int updateSchedule(MealSchedule mealSchedule) {
		return mealDao.updateSchedule(mealSchedule);
	}

	// 먹은 양 저장
	public int insertMeal(MealEaten mealEaten) {
		return mealDao.insertMeal(mealEaten);
	}

	// catId로 스케쥴 정보 조회
	public int getScheduleByCatId(int catId) {
		return mealDao.selectScheduleByCatId(catId);
	}

}
