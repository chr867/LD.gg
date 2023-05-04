package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.AdminDao;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminService {
	@Autowired
	AdminDao ad;
	
	public List<NoticeDto> get_notice_history() {
		List<NoticeDto> n_list = ad.get_notice_history();
		log.info("공지 목록 = {}", n_list);
		
		return n_list;
	}

	public NoticeDto get_notice_detail(Integer t_b_num) {
		NoticeDto notice = ad.get_notice_detail(t_b_num);
		log.info("공지 상세 = {}", notice);

		return notice;
	}

	public void increase_views(int t_b_num) {
		Boolean result = ad.increase_views(t_b_num);
		if(!result) {
			log.info("조회수 에러");
		}
	}

	public List<NoticeDto> search_notice(String keyword) {
		List<NoticeDto> n_list = ad.search_notice(keyword);
		log.info("공지 검색 결과 = {}", n_list);
		
		return n_list;
	}

	public boolean write_notice(NoticeDto nd) {
		boolean result = ad.write_notice(nd);
		log.info("글 작성 결과 = {}", result);
		return result;
	}

	public Boolean modify_notice(NoticeDto nd) {
		boolean b_result = ad.modify_notice(nd);
		log.info("공지 수정 결과 = {}", b_result);
		return b_result;
	}

	public boolean AdInsert(AdDto aDto) {
		int insertResult = ad.insertAd(aDto);
		if(insertResult != 0) {
			return true;
		}else
			return false;
	}

	public List<AdDto> getAdList() {
		List<AdDto> adList = ad.getAdList();
		return adList;
	}

	public List<AdDto> getSearchAdList(String keyword) {
		List<AdDto> adList = ad.getSearchAdList(keyword);
		return adList;
	}
	
	

}
