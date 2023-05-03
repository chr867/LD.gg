package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;

public interface Summoner_dao {

	List<SummonerRankDto> get_summoer_solo();

	List<SummonerRankDto> get_summoner_flex();

	List<SummonerRankDto> get_summoner_level();

	List<SummonerDto> get_summoner_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_summoner_record(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_renewal_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_champ_position_filter(@Param("summoner_name") String summoner_name);

	List<RecordInfoDto> get_record_info(@Param("summoner_name") String summoner_name);
	

}
