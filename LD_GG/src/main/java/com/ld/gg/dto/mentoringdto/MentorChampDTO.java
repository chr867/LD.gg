package com.ld.gg.dto.mentoringdto;

import org.apache.ibatis.type.Alias;

import com.ld.gg.dto.summoner.ChampRecordFilter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("mentorChamp")
public class MentorChampDTO {
	private int champion_id;
	private String champion_kr_name;
	private String champion_en_name;
	private int games;
	private int total_games;
	private float winrate;
	private float pick_rate;
	private float kda;
	private int kills;
	private int deaths;
	private int assists;
	private int cs;
	private float cs_per_minute;
	private int wins;
	private int losses;
	private String champ_name;
}
