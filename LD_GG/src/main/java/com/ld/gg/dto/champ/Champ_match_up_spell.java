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
}
