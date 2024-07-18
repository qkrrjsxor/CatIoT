package com.ssafy.ciot.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ciot.model.dto.Cat;
import com.ssafy.ciot.model.dto.SignupForm;
import com.ssafy.ciot.model.dto.User;
import com.ssafy.ciot.model.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/user")
public class UserController {

	// 의존성
	private UserService userService;
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	// 회원가입
	@PostMapping("/signup")
	public ResponseEntity<?> signup(@RequestBody SignupForm signupForm) {
		User user = signupForm.getUser();
        Cat cat = signupForm.getCat();
        
        if (userService.findByUserId(user.getUserId()) != null) {
        	System.out.println("이미 존재하는 아이디입니다.");
            return ResponseEntity.badRequest().body("UserId already exists.");
        }
        System.out.println("회원가입 성공");
        return ResponseEntity.ok(userService.signup(user, cat));
    }
	
	// 로그인
	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody User user, HttpSession session){
		System.out.println("로그인 컨트롤러 실행");
		User loginUser = userService.login(user.getUserId());
		
		if (loginUser == null) {
			return new ResponseEntity<String>("존재하지 않는 아이디입니다.", HttpStatus.UNAUTHORIZED);
		} else {
			if (!user.getPassword().equals(loginUser.getPassword())) {
				return new ResponseEntity<String>("비밀번호가 틀렸습니다.", HttpStatus.UNAUTHORIZED);
			} else {
				session.setAttribute("loginUser", loginUser.getUserId());
				System.out.println(session.getAttribute("loginUser") + " 로그인 성공");
				return new ResponseEntity<User>(loginUser, HttpStatus.OK);
			}
		}
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpSession session) {
		Object loginUser = session.getAttribute("loginUser");
		System.out.println("로그아웃 요청 - 로그인 유저: " + loginUser);
		
	    if (loginUser != null) {
	        System.out.println(loginUser + " 로그아웃 되었습니다.");
	        session.invalidate();
	        return new ResponseEntity<String>("로그아웃 되었습니다.", HttpStatus.ACCEPTED);
	    } else {
	        System.out.println("로그인한 유저가 없습니다.");
	        return new ResponseEntity<String>("로그인한 유저가 없습니다.", HttpStatus.UNAUTHORIZED);
	    }

	}
}
