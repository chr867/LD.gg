package com.ld.gg.dto.faq;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("cs")
public class CustomerServiceDTO {
	private int cs_id;
	private String cs_title;
	private String cs_info;
	private String cs_answerer_email;
}
