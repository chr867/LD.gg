package com.ld.gg.controller.summoner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;
import com.ld.gg.service.SummonerService;

@RestController

@RequestMapping(value = "/summoner")
public class SummonerRestController {
	
	@Autowired
	private SummonerService ss;
	
	@GetMapping("/solo")
	public List<SummonerRankDto> summoner_solo_rank(){
		List<SummonerRankDto> sd = ss.get_summoner_solo();
		return sd;
	}
	
	@GetMapping("/flex")
	public List<SummonerRankDto> summoner_flex_rank(){
		List<SummonerRankDto> sd = ss.get_summoner_flex();
		return sd;
	}
	
	@GetMapping("/level")
	public List<SummonerRankDto> summoner_level(){
		List<SummonerRankDto> sd = ss.get_summoner_level();
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
	
	@GetMapping("/get_record_info")
	public List<RecordInfoDto> get_record_info(String summoner_name){
		List<RecordInfoDto> rid = ss.get_record_info(summoner_name);
		return rid;
	}
	
	
	
}
