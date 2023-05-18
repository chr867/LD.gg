package com.ld.gg.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;
import com.ld.gg.dto.admin.NoticeReply;
import com.ld.gg.service.AdminService;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@RestController
@RequestMapping("/userinterface")
public class AdminRestController {
		@Autowired
		AdminService as;
	
		@RequestMapping("/notice/histroy.json")
		public String get_notice_history() throws Exception{
			List<NoticeDto> n_list = as.get_notice_history();
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(n_list);
			
			return json;
		}
		
		@GetMapping("/notice/search.json")
		public String search_notice_content(String keyword) throws Exception{
			log.info("search : {}", keyword);
			List<NoticeDto> n_list = as.search_notice(keyword);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(n_list);
			
			return json;
		}
		
		@GetMapping("/notice/reply-list.json")
		public List<NoticeReply> notice_reply_list(Integer t_b_num) throws Exception{
			List<NoticeReply> rp_list = as.get_notice_reply_list(t_b_num);
			log.info("notcie_reply : {}", rp_list);
			
			return rp_list;
		}

		@PostMapping("/notice/reply-insert.do")
		public boolean notice_reply_insert(HttpSession session, Integer t_b_num, String t_r_content) throws Exception{
			String email = session.getAttribute("email").toString();
			NoticeReply reply = new NoticeReply();
			log.info("reply email : {}", email);
			reply.setEmail(email).setT_b_num(t_b_num).setT_r_content(t_r_content);
			
			boolean result = as.insert_notice_reply(reply);
			return result;
		}

		@PostMapping("/notice/reply-delete.do")
		public int notice_reply_delete(HttpSession session, Integer t_r_num){
			String email = (String)session.getAttribute("email");
			int result = as.notice_reply_delete(email, t_r_num);

			return result;
		}

		@PostMapping("/notice/reply-modify")
		public boolean notice_reply_modify(HttpSession session, int t_r_num) {
			log.info(t_r_num+"번 댓글 데이터 가져오기 시작");
			String email = (String)session.getAttribute("email");
			NoticeReply repylInfo = as.get_reply_info(t_r_num);
			return email.equals(repylInfo.getEmail());
		}

		@PostMapping("/notice/reply-modify.do")
		public boolean notice_reply_modify(int t_r_num, String t_r_content) {
			log.info("댓글번호!"+t_r_num);
			log.info("댓글내용!"+t_r_content);
			NoticeReply n_reply = new NoticeReply();
			n_reply.setT_r_num(t_r_num).setT_r_content(t_r_content);
			boolean updateResult = as.notice_reply_update(t_r_num, t_r_content);
			
			return updateResult;
		}

		@PostMapping("/admin/ad/regist")
		public boolean adInsert(String ad_advertiser, String ad_name, String ad_start, String ad_end, int ad_pay) {
			
			AdDto aDto = new AdDto();
			aDto.setAd_advertiser(ad_advertiser);
			aDto.setAd_name(ad_name);
			aDto.setAd_start(ad_start);
			aDto.setAd_end(ad_end);
			aDto.setAd_pay(ad_pay);
			
			boolean insertResult = as.AdInsert(aDto);
			return insertResult;
		}
		
		@GetMapping("/admin/ad/lists.json")
		public String adList() throws Exception{
			List<AdDto> adList = as.getAdList();
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(adList);
			
			return json;
		}
		
		@GetMapping("/admin/ad/search.json")
		public String adList(String keyword) throws Exception{
			List<AdDto> adList = as.getSearchAdList(keyword);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(adList);
			
			return json;
		}
		
		@GetMapping("/admin/member/lists.json")
		public String mbLists() throws JsonProcessingException {
			List<MemberDto> memberLists = as.getMemberLists();
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(memberLists);
			return json;
		}
		
		@GetMapping("/admin/member/search.json")
		public String mbLists(String keyword) throws Exception{
			List<MemberDto> memberLists = as.getSearchMemberLists(keyword);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(memberLists);
			
			return json;
		}
		
		@GetMapping("/admin/member/history/lists.json")
		public String mbHistoryLists() throws JsonProcessingException {
			List<MemberDto> memberHistoryLists = as.getMemberHistoryLists();
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(memberHistoryLists);
			return json;
		}
		
		@GetMapping("/admin/member/history/search.json")
		public String mbHistoryLists(String keyword) throws Exception{
			List<MemberDto> memberHistoryLists = as.getSearchMemberHistoryLists(keyword);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(memberHistoryLists);
			
			return json;
		}	
		// 1 = 성공 2 = 실패
		@PostMapping("/admin/member/stop")
		public int mbStop(String email) throws Exception{
			int result = as.updateMemberStop(email, 4);
			return result;
		}
		
		@PostMapping("admin/forcedDrop")
		public int forcedDrop(String email) throws Exception{
			int result = as.forcedDrop(email);
			return result;
		}
		
		

}
