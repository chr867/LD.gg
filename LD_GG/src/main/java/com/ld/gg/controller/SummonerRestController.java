package com.ld.gg.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.SummonerDto;
import com.ld.gg.service.SummonerService;

@RestController
@RequestMapping(value = "/summoner")
public class SummonerRestController {
	private SummonerService ss;
	
	@GetMapping("/ranking")
	public List<SummonerDto> summoner_ranking(){
		List<SummonerDto> sd = ss.get_summoner_rank();
		return sd;
	}
	
	@GetMapping("/search")
	public SummonerDto search_summoner() {
		SummonerDto summoner = ss.get_summoner();
		return summoner;
	}

}
