package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.ld.gg.dto.summoner.ChampRecordDto;
import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;

public interface Summoner_dao {
	
	List<SummonerRankDto> getRankAllData();

	List<SummonerRankDto> get_summoer_solo();

	List<SummonerRankDto> get_summoner_flex();

	List<SummonerRankDto> get_summoner_level();

	List<SummonerDto> get_summoner_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_summoner_record(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_renewal_info(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_champ_position_filter(@Param("summoner_name") String summoner_name);

	List<ChampRecordDto> get_champ_record(@Param("summoner_name") String summoner_name);

	List<ChampRecordDto> get_20games_summary(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_record_detail(@Param("match_id") String match_id);

}
