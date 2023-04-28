package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_match_up")
public class Champ_match_up_default {
	private int left_champion;
	private int right_champion;
	private double match_up_win_rate;
	private double match_up_count;
}
