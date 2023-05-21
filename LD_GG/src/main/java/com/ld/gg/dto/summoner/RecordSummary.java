package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("recordsummary")
public class RecordSummary {
	private int wins;
	private int losses;
	private double winrate;
	private double kill_avg;
	private double deaths_avg;
	private double assists_avg;
	private double kda_avg;
	private double max_kda;
	private int max_kills;
	private int max_deaths;
	private int max_assists;
	private String top_champ1;
	private String top_champ2;
	private String top_champ3;
	private int top_champ1_wins;
	private int top_champ1_losses;
	private double top_champ1_winrate;
	private int top_champ2_wins;
	private int top_champ2_losses;
	private double top_champ2_winrate;
	private int top_champ3_wins;
	private int top_champ3_losses;
	private double top_champ3_winrate;
	private double top_champ1_kda_avg;
	private double top_champ2_kda_avg;
	private double top_champ3_kda_avg;
}
