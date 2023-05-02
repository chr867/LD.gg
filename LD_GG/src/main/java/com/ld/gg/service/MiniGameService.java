package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.MiniGameDao;
import com.ld.gg.dto.minigame.MiniGameDataDto;
import com.ld.gg.dto.minigame.MiniGameTimeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MiniGameService {
	@Autowired
	MiniGameDao md;
	
	public MiniGameDataDto data_minigame() {
		MiniGameDataDto data_dto = md.data_minigame();
		log.info("data_dto = {}", data_dto);
		
		return data_dto;
	}

	public MiniGameTimeDto timeline_minigame(Integer time) {
		MiniGameTimeDto timeline_dto = md.timeline_minigame(time);
		log.info("timeline_dto = {}", timeline_dto);
		
		return timeline_dto;
	}

	public int submit_minigame() {
		int result = md.submit_minigame();
		log.info("result = {}", result);
		
		return result;
	}

	public void point_update(Integer point) {
		boolean result = md.point_update(point);
		log.info("result = {}", result);
	}

}
