package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("champ_record")
@Accessors(chain = true)
public class ChampRecordDto {
	private String pick_position;
	private double pick_rate;
	private String champ_name;
	private int games;
	private int wins;
	private int losses;
	private double winrate;
	private double KDA;
	private int kills;
	private int deaths;
	private int assists;
	private int CS;
	private double CS_per_minute;
}
