package com.ssafy.ciot.model.dao;

import com.ssafy.ciot.model.dto.User;

public interface UserDao {
	// 회원가입
	public int insertUser(User user);

	// 로그인
	public User selectUser(String userId);
}
