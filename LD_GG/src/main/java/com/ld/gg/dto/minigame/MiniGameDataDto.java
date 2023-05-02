package com.ld.gg.dto.minigame;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("minigame_data")
public class MiniGameDataDto {
	private int minigame_result;
	private String match_id;
	private int mini_duration;
	private String mini_lane;
	private int mini_team;
	private int champion_id;
	private int mini_rune;
	private int mini_spell;
}
