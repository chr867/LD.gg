package com.ld.gg.dto;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("mate")//마이바티스 매핑용

public class MateDto {
	//게시글
	private int mate_id;//메이트 게시글 번호
	private String email;//메이트 게시글 작성자
	private String mate_content;//메이트 게시글 내용
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")private String mate_date;//메이트 게시글 작성일자
	private String mate_title;//메이트 게시글 제목
	private String lol_account;//작성자 롤 닉네임
	//댓글
//	private int mate_id;//메이트 게시글 번호
//	private String email;//메이트 게시글 작성자
	private String mate_apply;//메이트 신청 유저
	
	
	
}
