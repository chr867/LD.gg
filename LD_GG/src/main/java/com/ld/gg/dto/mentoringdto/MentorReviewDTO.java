package com.ld.gg.dto.mentoringdto;

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
@Alias("mentor_review")
public class MentorReviewDTO {
	private int review_num;
	private String reviewer_email;
	private int class_id;
	private int mentoring_id;
	private String review_content;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 HH:mm:ss")
	private LocalDateTime review_date;
	private String mentor_email;
	private float grade;
	private String reviewer_lol_account;
	private String mentor_lol_account;
	private String class_name;
	
}
