package com.ld.gg.dto.payment;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("payment")
public class PaymentDto {
	private String merchant_id;
	private String lol_account;
	private String email;
	private float price;
	private String payment_status;
	private String payment_method;
	private String imp_uid;
}
