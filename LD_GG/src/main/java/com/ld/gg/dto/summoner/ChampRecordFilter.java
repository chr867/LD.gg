package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ChampRecordFilter")
public class ChampRecordFilter {
	private String lane1;
	private String lane2;
	private String lane3;
	private double pick_rate1;
	private double pick_rate2;
	private double pick_rate3;
}
