package com.ld.gg.dao;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.minigame.MiniGameDataDto;
import com.ld.gg.dto.minigame.MiniGameTimeDto;

public interface MiniGameDao {

	MiniGameDataDto data_minigame();

	MiniGameTimeDto timeline_minigame(Integer time);

	int submit_minigame();

	boolean point_update(@Param("point")Integer point, @Param("email")String email);

}
