package com.ld.gg.dto.faq;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

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
	private String state;
	private String inquiries_title;
	private String inquiries_info;
	private String costomer_email;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 HH:mm:ss")
	private LocalDateTime date;
	private int views;
}
