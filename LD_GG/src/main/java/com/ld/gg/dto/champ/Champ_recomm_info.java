package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_recomm_info")
public class Champ_recomm_info {
	private int champion_id;
	private String team_position;
	private String item_id;
	private int pick_count;
	private int win_count;
	private double win_rate;
	private double pick_rate;
	private String mythic_item;
	
    private String MAIN_KEYSTONE_ID;
    private String MAIN_SUB1_ID;
    private String MAIN_SUB2_ID;
    private String MAIN_SUB3_ID;
    private String SUB_SUB1_ID;
    private String SUB_SUB2_ID;
    private String FRAGMENT1_ID;
    private String FRAGMENT2_ID;
    private String FRAGMENT3_ID;
    private String MAIN_SUB4_ID;
    private String SUB_KEYSTONE_ID;
    private String item_build;
    private String skill_build;
    private String mastery_sequence;
    private String MAIN_KEYSTONE_ID_img;
    private String MAIN_SUB1_ID_img;
    private String SUB_KEYSTONE_ID_img;
    
    private String spells;
    
    private double ban_rate;
    private int tier;
    
    private int enemy_champ_id;
    private double match_up_win_rate;
    
    private String champion_img;
}
