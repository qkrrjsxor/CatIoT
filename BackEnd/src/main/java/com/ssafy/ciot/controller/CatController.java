package com.ssafy.ciot.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ciot.model.dto.Cat;
import com.ssafy.ciot.model.service.CatService;

@RestController
@RequestMapping("/api/cat")
public class CatController {
	
	// 의존성
	private CatService catService;
	public CatController(CatService catService) {
		this.catService = catService;
	}
	
}
