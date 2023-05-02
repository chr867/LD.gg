package com.ld.gg.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String t_b_date;
	private int champion_id;
	private String email;
	
	private int t_r_num;
	private String t_r_content;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private	String t_r_date;
	
}
