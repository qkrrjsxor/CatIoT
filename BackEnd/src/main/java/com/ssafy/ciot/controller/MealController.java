package com.ssafy.ciot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.ssafy.ciot.model.dto.MealEaten;
import com.ssafy.ciot.model.dto.MealFeed;
import com.ssafy.ciot.model.dto.MealSchedule;
import com.ssafy.ciot.model.service.MealService;



@RestController
@RequestMapping("/api/meal")
public class MealController {
//public class MealController implements CommandLineRunner {

	// service 의존성
	private MealService mealService;
	public MealController(MealService mealService) {
		this.mealService = mealService;
	}
	@Autowired
    private RestTemplate restTemplate;
	
	String raspberryPiUrl = "http://192.168.4.2:500000";
	
	// 수동 급여
	@PostMapping("/manualfeed")
    public ResponseEntity<String> manualFeed(@RequestBody MealFeed mealFeed) {
        // 수동 급여 요청 catId, mealAmount를 받으면 라즈베리파이에 해당 catId 배급기에 mealAmount만큼 배급하라는 요청 보내기 
		int catId = mealFeed.getCatId();
		LocalDateTime mealDate = LocalDateTime.now();
		int mealAmount = mealFeed.getFeedAmount();
		
		System.out.println(mealDate);
		System.out.println("feedlId: " + mealFeed.getFeedId() + " mealDate : " + mealFeed.getFeedDate() + " catId : " + catId + " mealAmount : " + mealAmount);
		
		// 배급 내역 저장
		int result = mealService.insertFeed(catId, mealDate ,mealAmount);
		
		// 라즈베리파이로 배급 정보 보내기 ------------------------------------------------
		String url = "http://localhost:12345";
		// httpheader 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		// httpbody 설정s
		HttpEntity<MealFeed> entity = new HttpEntity<>(mealFeed, headers);
		// 라즈베리파이로 POST 요청 전송
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        return new ResponseEntity<>("Request sent to Raspberry Pi: " + response.getBody(), HttpStatus.OK);
    }
	
	
	// 라즈베리에서 get 요청 시(부팅 시) 자동 급여 스케줄 라즈베리파이에 전송
	@GetMapping("/getschedule/{catId}")
	public MealSchedule getSchedule(@PathVariable("catId") int catId) {
		MealSchedule mealSchedule = new MealSchedule();
		mealSchedule = mealService.getScheduleByCatId(catId);
		
		return mealSchedule;
	}
	
	// 자동 급여 스케줄 저장
	@PostMapping("/autofeed")
	public ResponseEntity<?> autoFeed(@RequestBody MealSchedule mealSchedule){
		
		int catId = mealSchedule.getCatId();
		MealSchedule isExist;
		int result;
		
		try {
			isExist = mealService.getScheduleByCatId(catId);
			
			if(isExist == null) {
				result = mealService.insertSchedule(mealSchedule);
			}else {
				// 자동 급여 스케줄 변경
				result = mealService.updateSchedule(mealSchedule);
			}
			
		} catch (Exception e) {
			result = mealService.insertSchedule(mealSchedule);
		}
		
		// 라즈베리파이 송신
		String url = raspberryPiUrl+"/api/meal/schedule";
		// 헤더 설정
		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		// 바디 설정
		HttpEntity<MealSchedule> entity = new HttpEntity<MealSchedule>(mealSchedule);
		// 라즈베리파이로 POST 요청 전송
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
		
		if(result == 1) {
			return new ResponseEntity<> ("스케줄 입력 성공" + response.getBody(), HttpStatus.OK);
		}else {
			return new ResponseEntity<> ("스케줄 입력 실패" + response.getBody(), HttpStatus.BAD_REQUEST);
		}
	}
	
	
	// 라즈베리파이에서 밥그릇 무게 센서 정보 받기
	@PostMapping("/eaten")
	public ResponseEntity<?> getMealEaten(@RequestBody MealEaten mealEaten){
		int catId = 1; //임시
		LocalDateTime time = mealEaten.getMealDate();
		int amount = mealEaten.getMealAmount();
		
		System.out.println("time : " + time + " amount : " + amount);
		
		return new ResponseEntity<> ("라즈베리파이 통신 테스트", HttpStatus.OK);
	}
	
//	// 소켓통신 test
//	@Override
//    public void run(String... args) {
//        String host = "127.0.0.1";  // 로컬호스트
//        int port = 12345;
//
//        System.out.println("시작");
//        try (Socket socket = new Socket(host, port);
//             PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
//             BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {
//
//        	System.out.println("while문 시작");
//            while (true) {
//                // 서버로 메시지 전송
//                out.println("Hello from Spring Boot");
//
//                // 서버로부터 응답 수신
//                String response = in.readLine();
//                if (response != null) {
//                    System.out.println("Received from server: " + response);
//                } else {
//                    System.out.println("No response from server");
//                }
//
//                Thread.sleep(3000);
//                System.out.println("3초");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
