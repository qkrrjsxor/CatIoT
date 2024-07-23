package com.ssafy.ciot.controller;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ciot.model.dto.MealEaten;
import com.ssafy.ciot.model.dto.MealFeed;
import com.ssafy.ciot.model.dto.MealSchedule;
import com.ssafy.ciot.model.service.MealService;


@RestController
@RequestMapping("/api/meal")
public class MealController {

	// service 의존성
	private MealService mealService;
	public MealController(MealService mealService) {
		this.mealService = mealService;
	}
	
	// 수동 급여
	@PostMapping("/manualfeed")
    public ResponseEntity<String> manualFeed(@RequestBody MealFeed mealFeed) {
        // 수동 급여 요청 catId, mealAmount를 받으면 라즈베리파이에 해당 catId 배급기에 mealAmount만큼 배급하라는 요청 보내기 
		int catId = mealFeed.getCatId();
		int mealAmount = mealFeed.getFeedAmount();
		
		System.out.println("catId : " + catId + " mealAmount : " + mealAmount);
        return new ResponseEntity<>("수동급여 완료", HttpStatus.OK); 
    }
	
	
	// 자동 급여 스케줄 라즈베리파이에 전송
	
	// 자동 급여 스케줄 저장
	@PostMapping("/autofeed")
	public ResponseEntity<?> autoFeed(@RequestBody MealSchedule mealSchedule){
		int count = mealSchedule.getScheduleCount();
		
		int result = mealService.insertSchedule(mealSchedule);
		
		if(result == 1) {
			return new ResponseEntity<> ("스케줄 입력 성공", HttpStatus.OK);
		}else {
			return new ResponseEntity<> ("스케줄 입력 실패", HttpStatus.BAD_REQUEST);
		}
		
	}
	
	// 자동 급여 스케줄 변경
	
	// 라즈베리파이에서 밥그릇 무게 센서 정보 받기
	@PostMapping("/eaten")
	public ResponseEntity<?> getMealEaten(@RequestBody MealEaten mealEaten){
		int catId = 1; //임시
		LocalDateTime time = mealEaten.getMealDate();
		int amount = mealEaten.getMealAmount();
		
		System.out.println("time : " + time + " amount : " + amount);
		
		return new ResponseEntity<> ("라즈베리파이 통신 테스트", HttpStatus.OK);
	}
	
}
