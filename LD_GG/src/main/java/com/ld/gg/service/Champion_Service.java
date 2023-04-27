package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.champ.Champ_dao;
import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class Champion_Service {
	@Autowired
	Champ_dao cd;
	
	public Champ_analytics champ_rank(String lane, String tier){
		
		Champ_analytics champ_list = cd.champ_rank(lane, tier);
		return champ_list;
	}
}
