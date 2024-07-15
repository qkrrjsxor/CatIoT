package com.ssafy.ciot.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ciot.model.dao.UserDao;
import com.ssafy.ciot.model.dto.User;

@Service
public class UserService {
	
	private final UserDao userDao;
	
	@Autowired
	public UserService (UserDao userDao) {
		this.userDao = userDao;
	}
	
	// 회원 가입
	public int signup(User user) {
		return userDao.insertUser(user);
	}
	
	// 로그인
	public User login(String userId) {
		return userDao.selectUser(userId);
	}
	
	// 조회
	public User findByUserId(String userId) {
		return userDao.selectUser(userId);
	}
}
