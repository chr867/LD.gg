package com.ld.gg.dto;

import org.apache.ibatis.type.Alias;

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
	private Integer user_type;
}
