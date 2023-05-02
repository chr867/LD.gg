package com.ld.gg.controller.summoner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.service.SummonerService;

@Controller
@RequestMapping("/summoner")
public class SummonerController {
	
	@Autowired
	private SummonerService ss;
	
	
	@GetMapping(value = "/rank")
	public String summoner_rank() {
		return "summoner/summonerRank";
	}
	
	@GetMapping(value = "/info")
	public ModelAndView summoner_info(String summoner_name) {
		List<SummonerDto> s = ss.get_summoner_info(summoner_name);
		return new ModelAndView("info").addObject("summoner", s);
	}
	
	@PostMapping(value = "/renewal")
	public List<SummonerDto> renewal_info(String summoner_name){
		List<SummonerDto> s = ss.get_renewal_info(summoner_name);
		return s;
	}
}
