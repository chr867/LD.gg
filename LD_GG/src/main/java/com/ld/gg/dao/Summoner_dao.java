package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.ld.gg.dto.summoner.BuildDto;
import com.ld.gg.dto.summoner.ChampRecordDto;
import com.ld.gg.dto.summoner.DashBoardDto;
import com.ld.gg.dto.summoner.MatchUpPlayerDto;
import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.RecordRankingDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;

public interface Summoner_dao {
	
	List<SummonerRankDto> getRankLoadingData();

	List<SummonerRankDto> getRankSoloData();

	List<SummonerRankDto> getRankFlexData();

	List<SummonerRankDto> getRankLevelData();

	SummonerDto get_summoner_info(@Param("summoner_name") String summoner_name);

	List<RecordDto> get_summoner_record(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_renewal_info(@Param("summoner_name") String summoner_name);

	List<SummonerDto> get_champ_position_filter(@Param("summoner_name") String summoner_name);

	List<ChampRecordDto> get_champ_record(@Param("summoner_name") String summoner_name);

	List<ChampRecordDto> get_20games_summary(@Param("summoner_name") String summoner_name);

	List<RecordInfoDto> get_record_detail(@Param("match_id") String match_id);

	List<ChampRecordDto> getChampSolo(String summoner_name);

	List<ChampRecordDto> getChampFlex(String summoner_name);

	List<ChampRecordDto> getChampClassic(String summoner_name);

	List<BuildDto> getBuild(String match_id, String summoner_name);

	List<RecordRankingDto> getRanking(String match_id, String summoner_name);

	SummonerDto getSummoner(String lol_account);

	DashBoardDto getDashBoardKDA(String summoner_name);

	List<MatchUpPlayerDto> getMatchUpPlayer(String match_id);

}
