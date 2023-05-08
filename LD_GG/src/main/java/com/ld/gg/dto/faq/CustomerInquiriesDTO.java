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
@Alias("ci")
public class CustomerInquiriesDTO {
	private int inquiries_id;
	private String inquiries_title;
	private String inquiries_info;
	private String costomer_email;
}
