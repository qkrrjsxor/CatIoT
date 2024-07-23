package com.ssafy.ciot.model.service;

import org.springframework.stereotype.Service;

import com.ssafy.ciot.model.dao.CatDao;
import com.ssafy.ciot.model.dto.Cat;

@Service
public class CatService {
	// DAO 의존성
	private CatDao catDao;
	public CatService(CatDao catDao) {
		this.catDao = catDao;
	}
	
	// cat 선택
	public Cat selectCatByCatId(int catId) {
		return catDao.selectCatByCatId(catId);
	}
	
	// cat 모두 선택
	public Cat[] selectCatAll(String userId) {
		return catDao.selectCatAll(userId);
	}
}
