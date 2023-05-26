package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_item_info")
public class Champ_item_info {
	private int item_id;
	private String item_ability;
	private String item_kr_name;
	private String item_desc;
	private String item_img;
	private int item_pur_gold;
	private int item_sell_gold;
}
