package com.ssafy.ciot.model.service;

import org.springframework.stereotype.Service;

import com.ssafy.ciot.model.dao.ToiletDao;

@Service
public class ToiletService {
	// dao 의존성
	private ToiletDao toiletDao;
	public ToiletService(ToiletDao toiletDao) {
		this.toiletDao = toiletDao;
	}
	
	
}
