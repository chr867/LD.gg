package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_item")
public class Champ_match_up_item extends Champ_match_up_default{
	private int[] item_build;
	private int item_build_win_cnt;
	private int item_build_pick_cnt;
	private double item_build_win_rate;
	private double item_build_pick_rate;
	private int game_cnt;
	private int[] start_item;
	private int start_item_win_cnt;
	private int start_item_pick_cnt;
	private double start_item_win_rate;
	private double start_item_pick_rate;
	private int shoe_item;
	private int shoe_item_win_cnt;
	private double shoe_item_win_rate;
	private int shoe_item_pick_rate;
	private int mythic_item;
	private int mythic_item_win_cnt;
	private int mythic_item_pick_cnt;
	private int mythic_item_win_rate;
	private int mythic_item_pick_rate;	
}
