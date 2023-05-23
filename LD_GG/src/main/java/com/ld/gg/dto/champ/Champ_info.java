package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_info")
public class Champ_info {
	private int champion_id;
	private String champion_en_name;
	private String champion_kr_name;
	private String champion_title;
	private String champion_tag;
	private String champion_img;
	private String champion_p_name;
	private String champion_q_name;
	private String champion_w_name;
	private String champion_e_name;
	private String champion_r_name;
	private String champion_q_id;
	private String champion_w_id;
	private String champion_e_id;
	private String champion_r_id;
	private String champion_p_desc;
	private String champion_q_desc;
	private String champion_w_desc;
	private String champion_e_desc;
	private String champion_r_desc;
	private String champion_q_tt;
	private String champion_w_tt;
	private String champion_e_tt;
	private String champion_r_tt;
	private String champion_p_img;
	private String champion_q_img;
	private String champion_w_img;
	private String champion_e_img;
	private String champion_r_img;

	
	
}
