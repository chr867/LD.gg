package com.ld.gg.controller.summoner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.summoner.BuildDto;
import com.ld.gg.dto.summoner.ChampRecordDto;
import com.ld.gg.dto.summoner.DashBoardDto;
import com.ld.gg.dto.summoner.MatchUpPlayerDto;
import com.ld.gg.dto.summoner.RecordDto;
import com.ld.gg.dto.summoner.RecordInfoDto;
import com.ld.gg.dto.summoner.RecordRankingDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.dto.summoner.SummonerRankDto;
import com.ld.gg.dto.summoner.TeamRankingDataDto;
import com.ld.gg.service.SummonerService;

@RestController

@RequestMapping(value = "/summoner")
public class SummonerRestController {

	@Autowired
	private SummonerService ss;

	@GetMapping("/rank/solo/loading/data.json")
	public String loadingData() throws Exception {
		List<SummonerRankDto> srd = ss.getRankLoadingData();

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(srd);

		return json;
	}

	@GetMapping("/rank/solo/data.json")
	public String soloRankData() throws Exception {
		List<SummonerRankDto> srd = ss.getRankSoloData();

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(srd);

		return json;
	}

	@GetMapping("/rank/flex/data.json")
	public String flexRankData() throws Exception {
		List<SummonerRankDto> srd = ss.getRankFlexData();

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(srd);

		return json;
	}

	@GetMapping("/rank/level/data.json")
	public String levelData() throws Exception {
		List<SummonerRankDto> srd = ss.getRankLevelData();

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(srd);

		return json;
	}

	@GetMapping("/get_summoner_record")
	public List<RecordDto> summoner_record(String summoner_name, int offset) {
		List<RecordDto> rd = ss.get_summoner_record(summoner_name, offset);
		return rd;
	}

	@GetMapping("/get_champ_position_filter")
	public List<SummonerDto> get_position_filter(String summoner_name) {
		List<SummonerDto> sd = ss.get_champ_position_filter(summoner_name);
		return sd;
	}

	@GetMapping("/get_champ_record")
	public List<ChampRecordDto> get_champ_record(String summoner_name, int offset) {
		List<ChampRecordDto> crd = ss.get_champ_record(summoner_name, offset);
		return crd;
	}
	
	@GetMapping("/getChampRecordLane")
	public List<ChampRecordDto> getChampRecordLane(String summoner_name, String paramLane, int offset){
		List<ChampRecordDto> crd = ss.getChampRecordLane(summoner_name, paramLane, offset);
		return crd;
	}
	
	@GetMapping("/get_champ_solo")
	public List<ChampRecordDto> getChampSolo(String summoner_name){
		List<ChampRecordDto> crd = ss.getChampSolo(summoner_name);
		return crd;
	}
	
	@GetMapping("/get_champ_flex")
	public List<ChampRecordDto> getChampFlex(String summoner_name){
		List<ChampRecordDto> crd = ss.getChampFlex(summoner_name);
		return crd;
	}
	
	@GetMapping("/get_champ_classic")
	public List<ChampRecordDto> getChampClassic(String summoner_name){
		List<ChampRecordDto> crd = ss.getChampClassic(summoner_name);
		return crd;
	}

	@GetMapping("/get_20games_summary")
	public List<ChampRecordDto> get_20games_summary(String summoner_name) {
		List<ChampRecordDto> crd = ss.get_20games_summary(summoner_name);
		return crd;
	}

	@GetMapping("/get_record_detail")
	public List<RecordInfoDto> get_record_detail(String match_id) {
		List<RecordInfoDto> rd = ss.get_record_detail(match_id);
		return rd;
	}
	
	@GetMapping("/info/getBuild")
	public BuildDto getBuild(String match_id, String summoner_name){
		BuildDto bd = ss.getBuild(match_id, summoner_name);
		return bd;
	}
	
	@GetMapping("/getRanking")
	public RecordRankingDto getRanking(String match_id,String summoner_name){
		RecordRankingDto rrd = ss.getRanking(match_id, summoner_name);
		return rrd;
	}
	
	@GetMapping("/dashboard/kda")
	public DashBoardDto getDashBoardKDA(String summoner_name){
		DashBoardDto dbd = ss.getDashBoardKDA(summoner_name);
		return dbd;
	}
	
	@GetMapping("/dashboard/matchup")
	public List<DashBoardDto> getDashBoardMatchUp(String summoner_name){
		List<DashBoardDto> dbd = ss.getDashBoardMatchUp(summoner_name);
		return dbd;
	}
	
	@GetMapping("/dashboard/recent")
	public List<DashBoardDto> getDashBoardRecent(String summoner_name){
		List<DashBoardDto> dbd = ss.getDashBoardRecent(summoner_name);
		return dbd;
	}
	
	@GetMapping("/dashboard/getPlayer")
	public List<DashBoardDto> getDashBoardPlayer(String match_id, String summoner_name){
		List<DashBoardDto> dbd = ss.getDashBoardPlayer(match_id, summoner_name);
		return dbd;
	}
	
	@GetMapping("/dashboard/profile")
	public DashBoardDto getDashBoardProfile(String summoner_name) {
		DashBoardDto dbd = ss.getDashBoardProfile(summoner_name);
		return dbd;
	}
	
	@GetMapping("/getMatchUpPlayer")
	public List<MatchUpPlayerDto> getMachUpPlayer(String match_id){
		List<MatchUpPlayerDto> mpd = ss.getMatchUpPlayer(match_id);
		return mpd;
	}
	 
	@GetMapping("/getTeamData")
	public List<TeamRankingDataDto> getTeamData(String match_id, String summoner_name){
		List<TeamRankingDataDto> TRDD = ss.getTeamData(match_id, summoner_name);
		return TRDD;
	}
	
	@GetMapping("/getMainMaking")
	public List<BuildDto> getMainMaking(String main){
		List<BuildDto> RBD = ss.getMainMaking(main);
		System.out.println(RBD);
		return RBD;
	}
	
	@GetMapping("/getSubMaking")
	public List<BuildDto> getSubMaking(String sub){
		List<BuildDto> RBD = ss.getSubMaking(sub);
		System.out.println(RBD);
		return RBD;
	}

}
