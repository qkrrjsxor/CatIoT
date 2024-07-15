package com.ssafy.ciot.model.dto;

import java.time.LocalDateTime;

// 날짜별 먹은 양을 저장하는 dto
public class MealEaten {
	private int mealId;
	private int catId;
	private LocalDateTime mealDate;	// 날짜
	private int mealEatenAmount;	// 먹은 양
}
