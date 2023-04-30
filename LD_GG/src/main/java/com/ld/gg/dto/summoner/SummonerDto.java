package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("summoner")
public class SummonerDto {
	private String summoner_name;
	private int s_level;
	private String profile_icon_id;
	private int games;
	private int wins;
	private int lose;
	private double winrate;
	private int lp;
	private String most_champ_id1;
	private String most_champ_id2;
	private String most_chamnp_id3;
	private String tier;
	private String game_mode;
}
