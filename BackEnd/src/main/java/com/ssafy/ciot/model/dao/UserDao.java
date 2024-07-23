package com.ssafy.ciot.model.dao;

import com.ssafy.ciot.model.dto.Cat;
import com.ssafy.ciot.model.dto.User;

public interface UserDao {
	// 회원가입
	public int insertUser(User user);
	
	// 고양이 테이블도 등록
	public int insertCat(Cat cat);
	
	// 로그인
	public User selectUser(String userId);
}
