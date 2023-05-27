package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("dashboard")
public class DashBoardDto {
	private int wins;
	private int losses;
	private double kills_avg;
	private double deaths_avg;
	private double assists_avg;
	private double kda_avg;
	private double kill_involve;
	private String champ_name;
	private double winrate;
	private String match_id;
	private String summoner_name;
	private int win;
	private String profile_icon_id;
	private String tier;
}
