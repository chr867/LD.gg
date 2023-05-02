package com.ld.gg.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.NoticeDto;
import com.ld.gg.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/userinterface/notice")
public class AdminRestController {
		@Autowired
		AdminService as;
	
		@RequestMapping("/histroy.json")
		public String get_notice_history() throws Exception{
			List<NoticeDto> n_list = as.get_notice_history();
			
			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(n_list);
			
			return json;
		}
		
		@RequestMapping("/search.json")
		public String search_notice_content(String t_b_content) throws Exception{
			List<NoticeDto> n_list = as.search_notice(t_b_content);

			ObjectMapper mapper = new ObjectMapper();
			String json = null;
			json = mapper.writeValueAsString(n_list);
			
			return json;
		}
		
		@RequestMapping("/modify.json")
		public String notice_modify() {

			return null;
		}
}
