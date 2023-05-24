package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("matchUpPlayer")
public class MatchUpPlayerDto {
	private String player;
	private String champ_name;
	private int team_id;
}
