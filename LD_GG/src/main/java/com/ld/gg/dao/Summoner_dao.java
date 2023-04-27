package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.SummonerDto;

public interface Summoner_dao {

	List<SummonerDto> get_summoer_rank();

	SummonerDto get_summoer();
	

}
