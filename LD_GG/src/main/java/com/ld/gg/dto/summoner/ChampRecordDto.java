package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("champ_record")
@Accessors(chain = true)
public class ChampRecordDto {
	private int games;
	private float winrate;
	private float kda;
	private int kills;
	private int deaths;
	private int assists;
	private int cs;
	private float cs_per_minute;
	private int wins;
	private int losses;
	private String champ_name;
	private String champion_kr_name;
}
