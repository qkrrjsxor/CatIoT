package com.ssafy.ciot.model.dto;

import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

// 고양이별 자동 급여 스케쥴 시간 & 양
public class MealSchedule {
	private int scheduleId;
	private int catId;
	private int scheduleCount;	// 횟수
	@JsonFormat(pattern = "HH:mm")
	private LocalTime scheduleTime1;	// 배급 시간
	@JsonFormat(pattern = "HH:mm")
	private LocalTime scheduleTime2;	// 배급 시간
	@JsonFormat(pattern = "HH:mm")
	private LocalTime scheduleTime3;	// 배급 시간
	@JsonFormat(pattern = "HH:mm")
	private LocalTime scheduleTime4;	// 배급 시간
	@JsonFormat(pattern = "HH:mm")
	private LocalTime scheduleTime5;	// 배급 시간
	private int scheduleAmount1;	// 배급량
	private int scheduleAmount2;	// 배급량
	private int scheduleAmount3;	// 배급량
	private int scheduleAmount4;	// 배급량
	private int scheduleAmount5;	// 배급량
	
	public MealSchedule() {}

	public int getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public int getScheduleCount() {
		return scheduleCount;
	}

	public void setScheduleCount(int scheduleCount) {
		this.scheduleCount = scheduleCount;
	}

	public LocalTime getScheduleTime1() {
		return scheduleTime1;
	}

	public void setScheduleTime1(LocalTime scheduleTime1) {
		this.scheduleTime1 = scheduleTime1;
	}

	public LocalTime getScheduleTime2() {
		return scheduleTime2;
	}

	public void setScheduleTime2(LocalTime scheduleTime2) {
		this.scheduleTime2 = scheduleTime2;
	}

	public LocalTime getScheduleTime3() {
		return scheduleTime3;
	}

	public void setScheduleTime3(LocalTime scheduleTime3) {
		this.scheduleTime3 = scheduleTime3;
	}

	public LocalTime getScheduleTime4() {
		return scheduleTime4;
	}

	public void setScheduleTime4(LocalTime scheduleTime4) {
		this.scheduleTime4 = scheduleTime4;
	}

	public LocalTime getScheduleTime5() {
		return scheduleTime5;
	}

	public void setScheduleTime5(LocalTime scheduleTime5) {
		this.scheduleTime5 = scheduleTime5;
	}

	public int getScheduleAmount1() {
		return scheduleAmount1;
	}

	public void setScheduleAmount1(int scheduleAmount1) {
		this.scheduleAmount1 = scheduleAmount1;
	}

	public int getScheduleAmount2() {
		return scheduleAmount2;
	}

	public void setScheduleAmount2(int scheduleAmount2) {
		this.scheduleAmount2 = scheduleAmount2;
	}

	public int getScheduleAmount3() {
		return scheduleAmount3;
	}

	public void setScheduleAmount3(int scheduleAmount3) {
		this.scheduleAmount3 = scheduleAmount3;
	}

	public int getScheduleAmount4() {
		return scheduleAmount4;
	}

	public void setScheduleAmount4(int scheduleAmount4) {
		this.scheduleAmount4 = scheduleAmount4;
	}

	public int getScheduleAmount5() {
		return scheduleAmount5;
	}

	public void setScheduleAmount5(int scheduleAmount5) {
		this.scheduleAmount5 = scheduleAmount5;
	}
		
}
