package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.TipDto;

public interface TipDao {

	Integer insertTip(TipDto tDto);

	List<TipDto> getBoardList();

	List<TipDto> getSearchList(String keyword);

	TipDto getTipDetails(int t_b_num);

	void updateView(TipDto tipDetails);
	
}
