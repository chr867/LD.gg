package com.ld.gg.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MateDto;
import com.ld.gg.dto.TipDto;

public interface MateDao {
	List<MateDto> getBoardList();
	List<MateDto> getReplyList(int mate_id);
	
	MateDto getMateDetails(int mate_id);
	MateDto getMateInfo(int mate_id);
	MateDto getReplyInfo(int mate_id);
	MateDto getReplySelect(int mate_id);
	Integer insertMate(MateDto mDto);
	
	Integer mateReplyInsert(MateDto mDto);
	Integer mateModify(MateDto mDto);
	Integer replyMateModify(MateDto mDto);
	Integer mateDelete(int mate_id);
	Integer replydelete(@Param("mate_id") int mate_id,@Param("mate_r_id") int mate_r_id);
	List<MateDto> getSearchList(String keyword);
	Integer modifybookmark( @Param("bookmark_page")String bookmark_page,@Param("bookmark_val") int bookmark_val,@Param("email") String email);
	MateDto getBookmark(String email);
}
