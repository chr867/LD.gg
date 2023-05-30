package com.ld.gg.dto.payment;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("trade")
public class TradeDto {
	private int points_received;
}
