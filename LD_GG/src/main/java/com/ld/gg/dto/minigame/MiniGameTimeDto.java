package com.ld.gg.dto.minigame;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("minigame_time")
public class MiniGameTimeDto {
	private int mini_t_time;
	private int mini_t_level;
	private int mini_t_kda;
	private int mini_t_bounty;
	private int mini_t_skill_slot;
	private int mini_t_tower_kill;
	private int mini_t_ward;
	private int mini_t_total_gold;
	private String mini_position;
	private int minigame_result;
	private String match_id;
	private int item_id;
}
