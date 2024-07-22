package com.ssafy.ciot.model.dao;

import com.ssafy.ciot.model.dto.Toilet;

public interface ToiletDao {
	// 배변 기록 삽입
	public int insertToilet(Toilet toilet);
	
}
