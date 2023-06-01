package com.ld.gg.dto.payment;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("usage")
public class UsageHistoryDto {
	private String tx_date;
	private int points_sent;
	private String merchant_id;
	private int price;
	private String sender_id;
	private String receiver_id;
	private int points_received;
}
