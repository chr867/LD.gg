package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("summoner_rank")
public class SummonerRankDto {
	private String summoner_name;
	private String tier;
	private String division;
	private String queue;
	private String league_id;
	private int lp;
	private int wins;
	private int losses;
	private double winrate;
	private int s_level;
	private String profile_icon_id;
	private String revision_date;
}
