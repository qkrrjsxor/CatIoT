package com.ssafy.ciot.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ciot.model.dto.MealEaten;
import com.ssafy.ciot.model.service.MealService;


@RestController
@RequestMapping("/api/meal")
public class MealController {

	// service 의존성
	private MealService mealService;
	public MealController(MealService mealService) {
		this.mealService = mealService;
	}
	
	//수동 급여
	@PostMapping("/manual")
	public ResponseEntity<?> feed(@RequestBody MealEaten meal) {
		
		
	}
	
}
