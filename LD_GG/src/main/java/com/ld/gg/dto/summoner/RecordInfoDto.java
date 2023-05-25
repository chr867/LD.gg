package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("record_info")
@Accessors(chain = true)
public class RecordInfoDto {
	private String summoner_name;
	private int win;
	private int team_tower_kills;
	private int team_dragon_kills;
	private int team_baron_kills;
	private int team_id;
	private int team_champion_kills;
	private int team_champion_deaths;
	private int team_champion_assists;
	private String champ_name;
	private int champ_level;
	private String spell1;
	private String spell2;
	private String main_rune1;
	private String sub_rune;
	private int kills;
	private int deaths;
	private int assists;
	private double kda;
	private int cs;
	private int dealt_to_champ;
	private int item1;
	private int item2;
	private int item3;
	private int item4;
	private int item5;
	private int item6;
	private int item7;
	private String tier;
	private int kills_participation;
}
