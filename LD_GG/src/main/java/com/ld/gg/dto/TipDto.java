package com.ld.gg.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("tip")
public class TipDto {
	private int t_b_num;
	private String t_b_title;
	private String t_b_content;
	private int t_b_views;
	private int t_b_recom;
	private Date t_b_date;
	private int champion_id;
	private String email;
}
