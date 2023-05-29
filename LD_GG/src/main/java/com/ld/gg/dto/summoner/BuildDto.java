package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("build")
@Accessors(chain = true)
public class BuildDto {
	private int main_rune;
	private int main_rune1;
	private int main_rune2;
	private int main_rune3;
	private int main_rune4;
	private int sub_rune;
	private int sub_rune1;
	private int sub_rune2;
	private int rune_stat1;
	private int rune_stat2;
	private int rune_stat3;
	private String main_rune_type;
	private String sub_rune_type;
	private int rune_id;
	private String rune_img;
	private int rune_num;
}
