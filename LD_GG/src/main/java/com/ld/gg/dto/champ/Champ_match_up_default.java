package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up")
public class Champ_match_up_default {
	private int champion_id;  // left_champion
	private String champion_name;
	private String champion_img;
	
	private int enemy_champ_id; // right_champion
	private String enemy_champ;
	private String enemy_champion_img;

	private int deal_to_champ;
	private int avg_g_15;
	private int avg_cs;
	
	private double match_up_win_rate;
	
	private int match_up_win_cnt;
	private int match_up_cnt;
	private String team_position;
	
	private double lane_kill_rate;
	private double enemy_lane_kill_rate;
	private double kill_participation;
	private double enemy_kill_participation;
	private double kda;
	private double enemy_kda;
	private int tower_kill_time;
	private int enemy_tower_kill_time;

	private double win_rate;
	private double enemy_win_rate;
	private double pick_rate;
	private double enemy_pick_rate;
	private double ban_rate;
	private double enemy_ban_rate;
}

