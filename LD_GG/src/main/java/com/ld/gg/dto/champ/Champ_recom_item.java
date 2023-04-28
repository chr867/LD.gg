package com.ld.gg.dto.champ;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("champ_recom_item")
public class Champ_recom_item {
	private int champion_id;
	private int start_item;
	private int shoes;
	private int first_core;
	private int second_core;
	private int third_core;
	private int fourth_core;
	private int fifth_core;
}
