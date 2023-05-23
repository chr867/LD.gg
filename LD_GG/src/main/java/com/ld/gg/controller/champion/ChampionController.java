package com.ld.gg.controller.champion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.TipDto;
import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_info;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_recomm_info;
import com.ld.gg.service.Champion_service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/champion")
public class ChampionController {
	@Autowired
	Champion_service cs;
	
	@GetMapping("/rank")
	public String go_champion_rank(/* Model model, @RequestParam(defaultValue = "top")String lane,
			@RequestParam(defaultValue = "platinum")String tier */) throws Exception{
//		Champ_analytics champ_rank = cs.champ_rank(lane, tier);
//		model.addAttribute("champ_rank", champ_rank);
		
		return "/champion/championRank";
	}
	
	@GetMapping("/info")
	public ModelAndView go_champion_info(@RequestParam("champion") int champion_id) throws Exception{
		Champ_info chamInfo = cs.getChampionInfo(champion_id);
		ModelAndView mav = new ModelAndView("champion/championInfo");
		mav.addObject("chamInfo",chamInfo);
		return mav;
	}
	
	
}
