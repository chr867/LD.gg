package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_analytics")
public class Champ_analytics extends Champ_default {
	private int gameDuration;
	private String gameVersion;
	private String summonerTier;
	private String champion_kr_name;
	private int champExperience;
	private String teamPosition;
	private int teamId;
	private String win;
	private int kills;
	private int deaths;
	private int assists;
	private int towerDestroy;
	private int inhibitorDestroy;
	private int dealToObject;
	private int dealToChampion;
	private int g_5;
	private int g_6;
	private int g_7;
	private int g_8;
	private int g_9;
	private int g_10;
	private int g_11;
	private int g_12;
	private int g_13;
	private int g_14;
	private int g_15;
	private int g_16;
	private int g_17;
	private int g_18;
	private int g_19;
	private int g_20;
	private int g_21;
	private int g_22;
	private int g_23;	
	private int g_25;
}
