package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_skill")
public class Champ_match_up_skill extends Champ_match_up_default{
	private int recom_skill1;
	private int recom_skill2;
	private int recom_skill3;
	private int recom_skill4;
	private int recom_skill5;
	private int recom_skill6;
	private int recom_skill7;
	private int recom_skill8;
	private int recom_skill9;
	private int recom_skill10;
	private int recom_skill11;
	private int recom_skill12;
	private int recom_skill13;
	private int recom_skill14;
	private int recom_skill15;
	private int recom_skill16;
	private int recom_skill17;
	private int recom_skill18;
}
