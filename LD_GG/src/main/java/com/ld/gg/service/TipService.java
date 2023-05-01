package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.TipDao;
import com.ld.gg.dto.TipDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TipService {
	@Autowired
	private TipDao tDao;

	public boolean tipWrite(TipDto tDto) {
		Integer insertResult = tDao.insertTip(tDto);
		
		if(insertResult != 0) {
			return true;
		}else {
			return false;
		}
	}
	
}
