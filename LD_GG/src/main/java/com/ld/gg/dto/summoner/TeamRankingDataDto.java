package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("teamData")
@Accessors(chain = true)
public class TeamRankingDataDto {
	private int team_dealt;
	private int team_damage;
	private int team_kills;
	private int team_deaths;
	private int team_assists;
	private int team_red_ward_placed;
	private int team_cs;
}
