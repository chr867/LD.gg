package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("record")
@Accessors(chain = true)
public class RecordDto {
	private String match_id;
	private String summoner_name;
	private String game_mode;
	private String champ_name;
	private int champ_level;
	private String team_id;
	private int win;
	private int kills;
	private int deaths;
	private int assists;
	private int KDA;
	private int cs;
	private String tier;
	private int game_duration;
	private String game_date;
	private String main_rune1;
	private String sub_rune;
	private String item1;
	private String item2;
	private String item3;
	private String item4;
	private String item5;
	private String item6;
	private String item7;
	private int red_ward_placed;
	private int dealt_to_champ;
	private String spell1;
	private String spell2;
	private int sight_point;
	private String player_champ_name;
}
