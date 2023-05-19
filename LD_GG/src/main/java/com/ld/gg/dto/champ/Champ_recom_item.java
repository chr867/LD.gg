package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_recom_item")
public class Champ_recom_item {
	private int champion_id;
	private String team_position;
	private int iteam_id;
	private int pick_count;
	private int win_count;
	private double win_rate;
	private double pick_rate;
}
