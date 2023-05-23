package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.champ.Champ_analytics;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.champ.Champ_match_up_default;
import com.ld.gg.dto.champ.Champ_match_up_item;
import com.ld.gg.dto.champ.Champ_match_up_rune;
import com.ld.gg.dto.champ.Champ_match_up_skill;
import com.ld.gg.dto.champ.Champ_match_up_spell;

public interface ChampDao {

	List<Champ_analytics> champ_rank(@Param("lane")String lane, @Param("tier")String tier);

	List<Champ_match_up_default> champ_match_up(Integer left_champion);

	List<Champ_match_up_default> champ_match_up_both(@Param("left_champion")Integer left_champion,
			@Param("right_champion")Integer right_champion);

	String champ_search(String champion_kr_name);

	String champ_search_eng(String champion_en_name);

	List<Champ_match_up_default> champ_recom(@Param("lane")String lane,
			@Param("tag")String tag, @Param("right_champion")String right_champion);

	List<Champ_match_up_spell> build_recom_spell(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion);

	List<Champ_match_up_item> build_recom_item(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion);

	List<Champ_match_up_rune> build_recom_rune(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion);

	List<Champ_match_up_skill> build_recom_skill(@Param("left_champion")String left_champion, @Param("right_champion")String right_champion);

  List<Champ_default> get_champ_list();

}
