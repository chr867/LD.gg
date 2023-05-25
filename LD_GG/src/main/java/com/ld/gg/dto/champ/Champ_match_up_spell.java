package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_spell")
public class Champ_match_up_spell extends Champ_match_up_default{
	private int d_spell;
	private int f_spell;
	private int win_cnt;
	private int pick_cnt;
	private int game_cnt;
	private double win_rate;
	private double pick_rate;
	
	private int spell_id;
	private String spell_kr_name;
	private String spell_desc; 
	private String spell_cooldown;
	private String spell_img;
}
