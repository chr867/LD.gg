package com.ld.gg.dto.admin;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;
@Data
@Accessors(chain=true)
@Alias("ad")
public class AdDto {
	private int ad_pay;
	private String ad_advertiser;
	private String ad_name;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String ad_term;

}
