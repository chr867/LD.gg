package com.ld.gg.controller.champion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_item_info;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_match_up_rune;
import com.ld.gg.dto.champ.Champ_match_up_spell;
import com.ld.gg.dto.champ.Champ_recomm_info;
import com.ld.gg.service.Champion_service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/champion")
public class ChampionRestController {
	@Autowired
	Champion_service cs;
	
	@GetMapping("/list.json")
	public List<Champ_default> get_champion_list() throws Exception{
		List<Champ_default> champ_list = cs.get_champ_list();
		return champ_list;
	}

	@PostMapping("/rank.json")
	public List<Champ_analytics> get_champion_rank(String lane, Integer tier) throws Exception{
		List<Champ_analytics> champ_rank = cs.champ_rank(lane, tier);
		return champ_rank;
	}
	
	@PostMapping("/search.json")
	public Champ_default champ_search(String champion_name) throws Exception{
		log.info("champion_name = {}", champion_name);
		Champ_default champion = cs.champ_search(champion_name);
		return champion;
	}

	@PostMapping(value="/search-eng.json", produces="text/plain;charset=UTF-8")
	public String champ_search_eng(String champion_en_name) throws Exception{

		String champion_kr_name = cs.champ_search_eng(champion_en_name);
		return champion_kr_name;
	}

	@PostMapping("/champ-recom.json")
	public List<Map<String, Object>> champ_recom(String lane, String tag, String right_champion) throws Exception{
		List<Map<String, Object>> cm_result = new ArrayList<>();
		List<Champ_match_up_default> cm_list = cs.champ_recom(lane, tag, right_champion);
		for(int i=0;i<cm_list.size();i++){
			Map<String, Object> tmp = new HashMap<>();
			String champion_kr_name = cs.champ_search_eng(cm_list.get(i).getChampion_name());
			tmp.put("cm", cm_list.get(i));
			tmp.put("name", champion_kr_name);
			cm_result.add(tmp);
		}
		log.info("cm_result = {}", cm_result);
		
		return cm_result;
	}

	@PostMapping("/build-recom.json")
	public Map<String, Object> build_recom(String left_champion, String right_champion, String team_position) throws Exception{
		Map<String, Object>build_map = cs.build_recom(left_champion, right_champion, team_position);
		return build_map;
	}
	
	
	@GetMapping("/info/lane")
	public List<Champ_recomm_info> championLaneData(int champion_id){
		List<Champ_recomm_info> champLaneData = cs.getChampionLaneData(champion_id);
		return champLaneData;
	}
	
	@GetMapping("/info/build")
	public Map<String, Object> championBuildInfo(@RequestParam("champion_id") int champion_id,@RequestParam("team_position") String team_position) throws Exception{
		Map<String, Object>championBuildInfo = cs.getChampionBuildInfo(champion_id, team_position);
		return championBuildInfo;
	}
	
	@GetMapping("/info/rune/main")
	public List<Champ_match_up_rune> mainRuneInfo(String main_key){
		List<Champ_match_up_rune> runeInfo = cs.getRuneInfo(main_key);
		return runeInfo;
	}
	@GetMapping("/info/rune/sub")
	public List<Champ_match_up_rune> subRuneInfo(String sub_key){
		List<Champ_match_up_rune> subRuneInfo = cs.getSubRuneInfo(sub_key);
		return subRuneInfo;
	}

	@PostMapping("/match-up.json")
	public Map<String, List<Champ_match_up_default>> champion_match_up(Integer champion_id) throws Exception{
		Map<String, List<Champ_match_up_default>> cm_map = cs.get_champ_match_up(champion_id);
		
		return cm_map;
	}
	
	@GetMapping("/info/spell")
	public List<Champ_match_up_spell> spellInfo(int first_spell, int second_spell){
		List<Champ_match_up_spell> spellInfo = cs.getSpellInfo(first_spell,second_spell);
		return spellInfo;
	}
	
	@PostMapping("/chart-lane.json")
	public Map<String, List<Champ_match_up_default>> chart_lane(Integer champion_id, String team_position) throws Exception{
		Map<String, List<Champ_match_up_default>> cm_map = cs.get_champ_match_up_chart(champion_id, team_position);

		return cm_map;
	}
	
	@GetMapping("/info/item")
	public List<Champ_item_info> itemInfo(int item_id){
		List<Champ_item_info> getItemInfo = cs.getItemInfo(item_id);
		return getItemInfo;
	}
}
