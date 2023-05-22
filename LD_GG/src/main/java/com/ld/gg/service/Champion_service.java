package com.ld.gg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.ChampDao;
import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_match_up_item;
import com.ld.gg.dto.champ.Champ_match_up_rune;
import com.ld.gg.dto.champ.Champ_match_up_skill;
import com.ld.gg.dto.champ.Champ_match_up_spell;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class Champion_service {
	@Autowired
	ChampDao cd;
	
	public List<Champ_analytics> champ_rank(String lane, String tier){
		List<Champ_analytics> champ_list = cd.champ_rank(lane, tier);
		log.info("champ_list = {}", champ_list);
		
		return champ_list;
	}

	public List<Champ_match_up_default> champ_match_up(Integer left_champion) {
		List<Champ_match_up_default> cm_list = cd.champ_match_up(left_champion);
		log.info("cm_list = {}", cm_list);
		
		return cm_list;
	}
	
	public List<Champ_match_up_default> champ_match_up_both(Integer left_champion, Integer right_champion) {
		List<Champ_match_up_default> cm_list = cd.champ_match_up_both(left_champion, right_champion);
		log.info("cm_list = {}", cm_list);
		
		return cm_list;
	}

	public String champ_search(String champion_kr_name) {
		String champion_en_name = cd.champ_search(champion_kr_name);
		log.info("champion_id = {}", champion_en_name);
		
		return champion_en_name;
	}

	public String champ_search_eng(String champion_en_name) {
		String champion_kr_name = cd.champ_search_eng(champion_en_name);
		log.info("champion_kr_name = {}", champion_kr_name);
		
		return champion_kr_name;
	}
	
	public List<Champ_match_up_default> champ_recom(String lane, String tag, String right_champion) {
		if(tag.equals("all")){
			tag="";
		}
		List<Champ_match_up_default> cm_list = cd.champ_recom(lane, tag, right_champion);
		log.info("cm_list = {}", cm_list);
		
		return cm_list;
	}

	public Map<String, Object> build_recom(String left_champion, String right_champion) {
		Map<String, Object> build_recom_map = new HashMap<String, Object>();
		
		List<Champ_match_up_spell> spell_recom = cd.build_recom_spell(left_champion, right_champion);	
		List<Champ_match_up_item> item_recom = cd.build_recom_item(left_champion, right_champion);
		List<Champ_match_up_rune> rune_recom = cd.build_recom_rune(left_champion, right_champion);
		List<Champ_match_up_skill> skill_recom = cd.build_recom_skill(left_champion, right_champion);
		
		build_recom_map.put("spell_recom", spell_recom);
		build_recom_map.put("item_recom", item_recom);
		build_recom_map.put("rune_recom", rune_recom);
		build_recom_map.put("skill_recom", skill_recom);
		log.info("build_recom_map = {}", build_recom_map);
		
		return build_recom_map;
	}

}
