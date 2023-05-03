package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.TipDto;

public interface TipDao {

	Integer insertTip(TipDto tDto);

	List<TipDto> getBoardList();

	List<TipDto> getSearchList(String keyword);

	TipDto getTipDetails(int t_b_num);

	void updateView(TipDto tipDetails);

	Integer recomInfo(TipDto tDto);

	int insertRecom(TipDto tDto);

	int deleteRecom(TipDto tDto);

	TipDto getTipinfo(int t_b_num);

	int updateModifyTip(TipDto tDto);

	int replyInsert(TipDto tDto);

	List<TipDto> getReplyList(int t_b_num);

	int deleteTip(int t_b_num);


	
}
