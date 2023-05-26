package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_rune")
public class Champ_match_up_rune extends Champ_match_up_default{
	private int main_keystone_id;
	private int main_sub1_id;
	private int main_sub2_id;
	private int main_sub3_id;
	private int main_sub4_id;
	private int sub_keystone_id;
	private int sub_sub1_id;
	private int sub_sub2_id;
	private int fragment1_id;
	private int fragment2_id;
	private int fragment3_id;
	private int win_cnt;
	private int pick_cnt;
	private int game_cnt;
	private double win_rate;
	private double pick_rate;

	private int rune_id;
	private int rune_num;
	private String rune_kr_name;
	private String rune_desc;
	private String rune_long_desc;
	private String rune_img;
	private String rune_type;
}
