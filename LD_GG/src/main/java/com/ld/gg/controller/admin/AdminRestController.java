package com.ld.gg.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.admin.AdDto;
import com.ld.gg.dto.admin.NoticeDto;
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
		

}
