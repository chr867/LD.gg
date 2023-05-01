package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.SummonerDto;

public interface Summoner_dao {

	List<SummonerDto> get_summoer_rank();

	List<SummonerDto> get_summoer_solo();

	List<SummonerDto> get_summoner_flex();

	List<SummonerDto> get_summoner_level();

	List<SummonerDto> get_summoner_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_summoner_record(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_renewal_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_champ_position_filter(@Param("summoner_name") String summoner_name);
	

}
