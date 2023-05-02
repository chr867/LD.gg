package com.ld.gg.dao;

import com.ld.gg.dto.minigame.MiniGameDataDto;
import com.ld.gg.dto.minigame.MiniGameTimeDto;

public interface MiniGameDao {

	MiniGameDataDto data_minigame();

	MiniGameTimeDto timeline_minigame(Integer time);

}
