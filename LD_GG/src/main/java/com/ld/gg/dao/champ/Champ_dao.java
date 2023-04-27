package com.ld.gg.dao.champ;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.champ.Champ_default;

public interface Champ_dao {

	Champ_default champ_rank(@Param("lane")String lane, @Param("tier")String tier);

}
