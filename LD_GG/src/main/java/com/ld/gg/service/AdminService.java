package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.AdminDao;
import com.ld.gg.dto.NoticeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminService {
	@Autowired
	AdminDao ad;
	
	public List<NoticeDto> get_notice_history() {
		List<NoticeDto> n_list = ad.get_notice_history();
		log.info("n_list = {}", n_list);
		
		return n_list;
	}
	
	

}
