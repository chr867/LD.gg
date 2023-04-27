package com.ld.gg.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ld.gg.dao.Summoner_dao;
import com.ld.gg.dto.SummonerDto;

@Service
public class SummonerService {
	private Summoner_dao SD;

	public List<SummonerDto> get_summoner_rank() {
		List<SummonerDto> sd = SD.get_summoer_rank();
		return sd;
	}

	public SummonerDto get_summoner() {
		SummonerDto summoner = SD.get_summoer();
		return summoner;
	}
	

}
