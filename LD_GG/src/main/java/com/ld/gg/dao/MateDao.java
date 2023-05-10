package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.MateDto;
import com.ld.gg.dto.TipDto;

public interface MateDao {
	List<MateDto> getBoardList();
	MateDto getMateDetails(int mate_id);
	Integer insertMate(MateDto mDto);
	
}
