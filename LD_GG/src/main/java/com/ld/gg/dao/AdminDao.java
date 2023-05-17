package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;
import com.ld.gg.dto.admin.NoticeReply;


public interface AdminDao {

	List<NoticeDto> get_notice_history();

	NoticeDto get_notice_detail(Integer t_b_num);

	Boolean increase_views(int t_b_num);

	List<NoticeDto> search_notice(String keyword);

	boolean write_notice(NoticeDto nd);

	boolean modify_notice(NoticeDto nd);

	List<NoticeReply> get_notice_reply_list(Integer t_b_num);

	int insertAd(AdDto aDto);

	List<AdDto> getAdList();

	List<AdDto> getSearchAdList(String keyword);

	List<MemberDto> getMemberLists();

	List<MemberDto> getSearchMemberLists(String keyword);

	List<MemberDto> getMemberHistoryLists();

	List<MemberDto> getSearchMemberHistoryLists(String keyword);

	int deleteForcedDrop(String email);

	boolean insert_notice_reply(NoticeReply reply);

}
