package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.MateDao;
import com.ld.gg.dto.MateDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MateService {
	@Autowired
	private MateDao mDao;
	
	public List<MateDto> getMateList() throws Exception{
		List<MateDto> mList = mDao.getMateList();
		log.info("{}",mList);
		return mList;
	}
}

