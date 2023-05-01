package com.ld.gg.dto;

import java.time.LocalDateTime;
import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("notice")
public class NoticeDto {
	private int t_b_num;
	private String t_b_content;
	private int t_b_views;
	private int t_b_recom;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private String t_b_date;
}
