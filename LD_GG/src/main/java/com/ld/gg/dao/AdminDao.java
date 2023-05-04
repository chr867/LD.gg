package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;

public interface AdminDao {

	List<NoticeDto> get_notice_history();

	NoticeDto get_notice_detail(Integer t_b_num);

	Boolean increase_views(int t_b_num);

	List<NoticeDto> search_notice(String keyword);

	boolean write_notice(NoticeDto nd);

	boolean modify_notice(NoticeDto nd);

	int insertAd(AdDto aDto);

	List<AdDto> getAdList();

	List<AdDto> getSearchAdList(String keyword);

}
