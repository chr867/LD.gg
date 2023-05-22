package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_list")
public class Champ_list{
	private int champion_id;
	private String team_position;
	private String champion_kr_name;
	private String champion_img;
	private String champion_en_name;
	
}
