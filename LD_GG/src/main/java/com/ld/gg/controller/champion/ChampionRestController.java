package com.ld.gg.controller.champion;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
	public List<Integer> champ_search(String champion_kr_name) throws Exception{

		List<Integer> c_list = cs.champ_search(champion_kr_name);
		return c_list;
	}

	@PostMapping("/champ-recom.json")
	public List<Champ_match_up_default> champ_recom(String lane, String tag, String right_champion) throws Exception{

		List<Champ_match_up_default> cm_list = cs.champ_recom(lane, tag, right_champion);
		return cm_list;
	}

	@PostMapping("/build-recom.json")
	public Map<String, Object> build_recom(String left_champion, String right_champion) throws Exception{

		Map<String, Object>build_map = cs.build_recom(left_champion, right_champion);
		return build_map;
	}
}
