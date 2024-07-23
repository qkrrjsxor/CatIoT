package com.ssafy.ciot.model.dao;

import java.time.LocalDateTime;

import org.apache.ibatis.annotations.Param;

import com.ssafy.ciot.model.dto.MealEaten;
import com.ssafy.ciot.model.dto.MealSchedule;

public interface MealDao {
	// 먹은 양 저장
	public int insertMeal(MealEaten mealEaten);
	
	// 스케줄 저장
	public int insertSchedule(MealSchedule mealSchedule);

	// 스케줄 업데이트
	public int updateSchedule(MealSchedule mealSchedule);

	// catId로 스케쥴 조회
	public int selectScheduleByCatId(int catId);

	// 급여 기록 저장
	public int insertFeed(@Param("catId") int catId, @Param("mealDate") LocalDateTime mealDate, @Param("mealAmount") int mealAmount);

}
