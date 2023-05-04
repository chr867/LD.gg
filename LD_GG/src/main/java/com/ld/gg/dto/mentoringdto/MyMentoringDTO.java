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
@Alias("myMentoring")
public class MyMentoringDTO {
	private String menti_email; //pk
	private int class_id; //pk
	private String class_name;
	private int menti_state; //0: 대기중, 1: 수강중, 2: 수강 완료
	private String mentor_email;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 HH:mm:ss")
	private LocalDateTime apply_date;
	//@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 HH:mm:ss")
	private LocalDateTime done_date;
	private String menti_lol_account;
	private String mentor_lol_account;
}
