package com.ld.gg.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("notice")
public class NoticeDto {
	private int t_b_num;
	private String t_b_content;
	private int t_b_view;
	private int t_b_recom;
	private Date t_b_date;
}
