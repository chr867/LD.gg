package com.ld.gg.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("member")
public class MemberDto {
	private String email;
	private String password;
	private String phone_num;
	private String lol_account;
	private int user_type;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String join_date;
}
