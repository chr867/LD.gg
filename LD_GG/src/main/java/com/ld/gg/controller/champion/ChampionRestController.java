package com.ld.gg.controller.champion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.service.Champion_service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/champion")
public class ChampionRestController {
	@Autowired
	Champion_service cs;
	
	@GetMapping("/search.json")
	public String champ_search(String champion_kr_name) throws Exception{
		List<Integer> c_list = cs.champ_search(champion_kr_name);

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(c_list);
		
		return json;
	}

	@GetMapping("/recom.json")
	public String champ_recom(String lane, String tag, String right_champion) throws Exception{
		List<Champ_match_up_default> cm_list = cs.champ_recom(lane, tag, right_champion);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(cm_list);
		
		return json;
	}
}
