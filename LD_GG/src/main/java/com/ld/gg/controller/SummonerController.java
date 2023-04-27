package com.ld.gg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.service.SummonerService;

@Controller
@RequestMapping("/summoner")
public class SummonerController {
	
	@GetMapping(value = "/rank")
	public String summoner_rank() {
		
		return "summonerRank";
	}
}
