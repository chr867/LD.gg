package com.ld.gg.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ld.gg.dao.AdminDao;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dao.SessionDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.SessionDto;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;
import com.ld.gg.dto.admin.NoticeReply;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminService {
	@Autowired
	private AdminDao ad;
	
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private SessionDao sDao;
	
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
	
  public List<NoticeReply> get_notice_reply_list(Integer t_b_num) {
		List<NoticeReply> rp_list = ad.get_notice_reply_list(t_b_num);
		log.info("공지 댓글 = {}", rp_list);

    return rp_list;
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

	public List<MemberDto> getMemberLists() {
		List<MemberDto> meberLists = ad.getMemberLists();
		return meberLists;
	}

	public List<MemberDto> getSearchMemberLists(String keyword) {
		List<MemberDto> meberLists = ad.getSearchMemberLists(keyword);
		return meberLists;
	}

	public List<MemberDto> getMemberHistoryLists() {
		List<MemberDto> meberHistoryLists = ad.getMemberHistoryLists();
		return meberHistoryLists;
	}

	public List<MemberDto> getSearchMemberHistoryLists(String keyword) {
		List<MemberDto> meberHistoryLists = ad.getSearchMemberHistoryLists(keyword);
		return meberHistoryLists;
	}

	public int updateMemberStop(String email, int user_type) {
		int updateResult = mDao.updateUserType(email, user_type);
		if(updateResult != 0) {
			return 1;
		}else {
			return 2;
		}
	}

	public int forcedDrop(String email) {
		try {
			int deleteResult = ad.deleteForcedDrop(email);
			if(deleteResult != 0) {
				return 1;
			}else
				return 2;
		} catch (Exception e) {
			e.printStackTrace();
			return 3;
		}
	}

	public boolean insert_notice_reply(NoticeReply reply) {
		boolean result = ad.insert_notice_reply(reply);
		return result;
	}

  public int notice_reply_delete(String email, Integer t_r_num) {
		int val;
		NoticeReply n_reply = ad.get_notice_reply(t_r_num);

		if(!email.equals(n_reply.getEmail())){
			val = 3;
		}else{
			boolean result = ad.delete_notice_reply(t_r_num);
			if(result){
				val = 1;
			}else{
				val = 2;
			}
		}

		return val;
  }

  public boolean notice_reply_update(int t_r_num, String t_r_content) {
		boolean result = ad.notice_reply_update(t_r_num, t_r_content);
		return result;
  }

	public NoticeReply get_reply_info(int t_r_num) {
		NoticeReply n_reply = ad.get_notice_reply(t_r_num);
		return n_reply;
	}

	@Transactional
	public String notice_delete(List<Integer> t_b_nums) {
		for(Integer t_b_num : t_b_nums) {
			log.info("t_b_num = {}", t_b_num);
			boolean tmp = ad.notice_delete(t_b_num);
			if(!tmp) {
				return "공지 삭제 실패";
			}
		}
		return "공지 삭제 성공";
	}

}
