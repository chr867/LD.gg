package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ")
public class Champ_analytics extends Champ_default {
	private int gameDuration;
	private String gameVersion;
	private String summoneTier;
	
}
