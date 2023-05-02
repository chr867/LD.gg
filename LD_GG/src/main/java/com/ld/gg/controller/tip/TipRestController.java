package com.ld.gg.controller.tip;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.TipDto;
import com.ld.gg.service.TipService;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@RestController
@RequestMapping("/tip")
public class TipRestController {
	@Autowired
	private TipService ts;
	
	@GetMapping("/list.json")
	public String tipList() throws Exception {
        
        List<TipDto> tipList = ts.getTipList();
        
        ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(tipList);
		
		return json;
	}
	
	@GetMapping("/search.json")
	public String tipSearch(String keyword) throws Exception {
		log.info("공략 게시판 검색 진입");
        log.info(keyword);
        List<TipDto> searchList = ts.getSearchList(keyword);
        
        ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(searchList);
		
		return json;
	}
	
	//retrun 1 = 추천 성공 , 2 = 추천취소 성공 , 3 = 오류, 4 = 로그인필요
	@PostMapping("/recom")
	public int tipRecom(HttpSession session, @RequestParam("t_b_num") int t_b_num) {
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return 4;
		}
		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_num(t_b_num);
		
		int recomResult = ts.recomUpdate(tDto);
		
		return recomResult;
	}
	
	@PostMapping("/reply_insert")
	public int replyInsert(HttpSession session, int t_b_num, String t_r_content) {
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return 4;
		}
		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_num(t_b_num);
		tDto.setT_r_content(t_r_content);
		
		int replyInsertResult = ts.replyInsert(tDto);
		
		return replyInsertResult;
	}
	
	@GetMapping("/replyList")
	public List<TipDto> replyList(int t_b_num) throws Exception{
        
        List<TipDto> replyList = ts.getReplyList(t_b_num);
		
		return replyList;
	}
	
	
}
