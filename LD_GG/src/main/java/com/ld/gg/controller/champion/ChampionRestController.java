package com.ld.gg.controller.champion;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_match_up_item;
import com.ld.gg.dto.champ.Champ_match_up_rune;
import com.ld.gg.dto.champ.Champ_match_up_skill;
import com.ld.gg.dto.champ.Champ_match_up_spell;
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

	@GetMapping("/champ-recom.json")
	public String champ_recom(String lane, String tag, String right_champion) throws Exception{
		List<Champ_match_up_default> cm_list = cs.champ_recom(lane, tag, right_champion);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(cm_list);
		
		return json;
	}

	@GetMapping("build-recom.json")
	public String build_recom(String left_champion, String right_champion) throws Exception{
		Map<String, Object>build_map = cs.build_recom(left_champion, right_champion);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(build_map);
		
		return json;
	}
}
