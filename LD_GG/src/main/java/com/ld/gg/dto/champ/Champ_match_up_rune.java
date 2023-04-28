package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up_rune")
public class Champ_match_up_rune extends Champ_match_up_default{
	private int keystone_id;
	private int main_sub1_id;
	private int main_sub2_id;
	private int main_sub3_id;
	private int sub_sub1_id;
	private int sub_sub2_id;
	private int fragment1_id;
	private int fragment2_id;
	private int fragment3_id;
}
