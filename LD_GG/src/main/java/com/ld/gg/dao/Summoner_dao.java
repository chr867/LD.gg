package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.SummonerDto;

public interface Summoner_dao {

	List<SummonerDto> get_summoer_rank();

	List<SummonerDto> get_summoer_solo();

	List<SummonerDto> get_summoner_flex();

	List<SummonerDto> get_summoner_level();
	

}
