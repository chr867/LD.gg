package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.TipDto;
import com.ld.gg.dto.champ.Champ_list;

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

	TipDto getReplyinfo(int t_r_num);

	int deleteReply(int t_r_num);

	int updateReply(TipDto tDto);

	List<TipDto> getsubReplyList(int t_r_num);

	int subReplyInsert(TipDto tDto);

	List<Champ_list> getChampionList();

	List<Champ_list> getChampionLane(String team_position);

	List<TipDto> getSearchIdList(int keyword);


	
}
