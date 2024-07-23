package com.ssafy.ciot.model.dao;

import com.ssafy.ciot.model.dto.Cat;

public interface CatDao {
	// cat선택
	public Cat selectCatByCatId(int catId);
	
	// cat 모두 선택
	public Cat[] selectCatAll(String userId);
}
