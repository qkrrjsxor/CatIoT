package com.ssafy.ciot.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = "com.ssafy.ciot.model.dao")
public class DBConfig {

}
	