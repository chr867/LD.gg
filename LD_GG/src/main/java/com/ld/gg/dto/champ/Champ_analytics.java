package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_analytics")
public class Champ_analytics extends Champ_default {
	private String team_position;
	private double win_rate;
	private double pick_rate;
	private double ban_rate;
	private int tier;
}
