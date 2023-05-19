package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_skill")
public class Champ_match_up_skill extends Champ_match_up_default{
	private String skill_build;
	private int skill_build_win_cnt;
	private int skill_build_pick_cnt;
	private double skill_build_win_rate;
	private double skill_build_pick_rate;
	private String skill_tree;
	private int skill_tree_win_cnt;
	private int skill_tree_pick_cnt;
	private double skill_tree_win_rate;
	private double skill_treed_pick_rate;
	private int game_cnt;
}
