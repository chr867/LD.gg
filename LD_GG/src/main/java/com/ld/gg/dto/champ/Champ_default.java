package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
//@Alias("champ")
public class Champ_default {
	private int champion_id;
	private String champion_en_name;
	private String champion_kr_name;
	private String champion_title;
	private String champion_tag;
	private String champion_img;
}
