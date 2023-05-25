package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("recordRanking")
@Accessors(chain = true)
public class RecordRankingDto {
	private int self_dealt;
	private int self_taken;
	private int self_kills;
	private int self_deaths;
	private int self_assists;
	private int self_red_ward_placed;
	private int self_cs;
	private int total_dealt;
	private int total_taken;
	private int team_champion_kills;
	private int team_champion_deaths;
	private int team_champion_assists;
	private int team_total_red_ward;
	private int team_total_cs;
}
