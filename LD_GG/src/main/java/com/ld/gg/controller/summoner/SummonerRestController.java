package com.ld.gg.controller.summoner;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.SummonerDto;
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
	
	@GetMapping("/solo")
	public List<SummonerDto> summoner_solo_rank(){
		List<SummonerDto> sd = ss.get_summoner_solo();
		return sd;
	}
	
	@GetMapping("/flex")
	public List<SummonerDto> summoner_flex_rank(){
		List<SummonerDto> sd = ss.get_summoner_flex();
		return sd;
	}
	
	@GetMapping("/level")
	public List<SummonerDto> summoner_level(){
		List<SummonerDto> sd = ss.get_summoner_level();
		return sd;
	}
	
	@GetMapping("/get_summoner_record")
	public List<RecordDto> summoner_record(String summoner_name){
		List<RecordDto> sr = ss.get_summoner_record(summoner_name);
		return sr;
	}
	
	@GetMapping("/get_champ_position_filter")
	public List<RecordDto> get_position_filter(String summoner_name){
		List<RecordDto> sr = ss.get_champ_position_filter(summoner_name);
		return sr;
	}
	
}
