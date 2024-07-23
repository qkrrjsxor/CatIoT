package com.ssafy.ciot.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ciot.model.service.ToiletService;

@RestController
@RequestMapping("/api/toilet")
public class ToiletController {
	
	// 의존성
	private ToiletService toiletService;
	public ToiletController(ToiletService toiletService) {
		this.toiletService = toiletService;
	}
	
	// 배변 기록 저장
//	@PostMapping("/get")
	
}
