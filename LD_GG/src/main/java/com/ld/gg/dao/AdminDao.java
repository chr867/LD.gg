package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.NoticeDto;

public interface AdminDao {

	List<NoticeDto> get_notice_history();

}
