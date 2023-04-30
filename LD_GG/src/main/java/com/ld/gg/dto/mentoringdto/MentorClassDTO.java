package com.ld.gg.dto.mentoringdto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("mentorClass")
public class MentorClassDTO {
	private int class_id; //pk
	private String mentor_email;
	private String class_name;
	private String class_info;
	private int price;
}
