package com.ld.gg.dao.champ;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;

public interface Champ_dao {

	Champ_analytics champ_rank(@Param("lane")String lane, @Param("tier")String tier);

	List<Champ_match_up_default> champ_match_up(Integer left_champion);

	List<Champ_match_up_default> champ_match_up_both(@Param("left_champion")Integer left_champion,
			@Param("right_champion")Integer right_champion);

	List<Integer> champ_search(String champion_kr_name);

	List<Champ_match_up_default> champ_recom(@Param("lane")String lane,
			@Param("tag")String tag, @Param("right_champion")String right_champion);

}
