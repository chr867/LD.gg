package com.ld.gg.controller.summoner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.summoner.ChampRecordDto;
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
		List<RecordDto> rd = ss.get_summoner_record(summoner_name);
		return rd;
	}
	
	@GetMapping("/get_champ_position_filter")
	public List<SummonerDto> get_position_filter(String summoner_name){
		List<SummonerDto> sd = ss.get_champ_position_filter(summoner_name);
		return sd;
	}
	
	@GetMapping("/get_champ_record")
	public List<ChampRecordDto> get_champ_record(String summoner_name){
		List<ChampRecordDto> crd = ss.get_champ_record(summoner_name);
		return crd;
	}
	
	@GetMapping("/get_20games_summary")
	public List<ChampRecordDto> get_20games_summary(String summoner_name){
		List<ChampRecordDto> crd = ss.get_20games_summary(summoner_name);
		return crd;
	}
	
	
}
