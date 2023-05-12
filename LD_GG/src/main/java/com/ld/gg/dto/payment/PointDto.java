package com.ld.gg.dto.payment;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("point")
public class PointDto {
	private String holder_email;
	private int point_balance;
	private String lol_account;
}
