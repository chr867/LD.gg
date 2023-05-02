package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.NoticeDto;

public interface AdminDao {

	List<NoticeDto> get_notice_history();

	NoticeDto get_notice_detail(int t_b_num);

	Boolean increase_views(int t_b_num);

	List<NoticeDto> search_notice(String keyword);

	boolean write_notice(NoticeDto nd);

}
