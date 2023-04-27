package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.Ex_dao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class Ex_service {
	@Autowired
	private Ex_dao e_dao;
	
	public void test() {
		log.info("{}", e_dao.test());
	}
	
	
}
