package com.ld.gg.dto.champ;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
//@Alias("champ")
public class Champ_default {
	private int champion_id;

//	상속 문제 발생시 한번 더 나눌 것
	private String champion_en_name;
	private String champion_kr_name;
	private String champion_title;
	private String champion_tag;
	private String champion_img;
}
