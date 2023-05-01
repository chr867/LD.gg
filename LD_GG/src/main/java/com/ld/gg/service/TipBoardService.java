package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.TipBoardDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TipBoardService {
	@Autowired
	private TipBoardDao Tipdao;
	
	
	
}
