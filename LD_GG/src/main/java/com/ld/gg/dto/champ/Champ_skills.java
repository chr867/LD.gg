package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
//@EqualsAndHashCode(callSuper=false)
@Accessors(chain=true)
@Alias("champ_skills")
public class Champ_skills extends Champ_default{
	
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
