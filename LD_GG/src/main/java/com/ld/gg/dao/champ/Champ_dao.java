package com.ld.gg.dao.champ;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.champ.Champ_analytics;

public interface Champ_dao {

	Champ_analytics champ_rank(@Param("lane")String lane, @Param("tier")String tier);

}
