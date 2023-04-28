package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.champ.Champ_dao;
import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class Champion_Service {
	@Autowired
	Champ_dao cd;
	
	public Champ_analytics champ_rank(String lane, String tier){
		Champ_analytics champ_list = cd.champ_rank(lane, tier);
		log.info("champ_list = {}", champ_list);
		
		return champ_list;
	}

	public List<Champ_match_up_default> champ_match_up(int left_champion) {
		List<Champ_match_up_default> cm_list = cd.champ_match_up(left_champion);
		log.info("cm_list = {}", cm_list);
		
		return cm_list;
	}
	
	public List<Champ_match_up_default> champ_match_up_both(int left_champion, int right_champion) {
		List<Champ_match_up_default> cm_list = cd.champ_match_up_both(left_champion, right_champion);
		log.info("cm_list = {}", cm_list);
		
		return cm_list;
	}

}
