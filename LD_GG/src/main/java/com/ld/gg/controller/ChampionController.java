package com.ld.gg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.service.Champion_Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/champion")
public class ChampionController {
	@Autowired
	Champion_Service cs;
	
	@GetMapping("/rank")
	public ModelAndView champion_rank(Model model, @RequestParam(defaultValue = "top")String lane,
			@RequestParam(defaultValue = "platinum")String tier) {

		ModelAndView mv = new ModelAndView();
		mv.addObject(cs.champ_rank(lane, tier));
		mv.setViewName("champion/championRank");
		return mv;
	}
}
