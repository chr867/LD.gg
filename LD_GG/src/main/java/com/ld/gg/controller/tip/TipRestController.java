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
	// 1 = 삭제성공 , 2 = 삭제실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/delete")
	public int tipDelete(HttpSession session, int t_b_num) throws Exception{
		log.info(t_b_num+"번 공략글 삭제 시작");
		String email = (String)session.getAttribute("email");
		TipDto tipInfo = ts.getTipinfo(t_b_num);
		if(email.equals(tipInfo.getEmail())) {
			int deleteResult = ts.tipDelete(t_b_num);
			return deleteResult;
		}else{
			return 3;
		}
	}
	
	//retrun 1 = 추천 성공 , 2 = 추천취소 성공 , 3 = 로그인필요, 4 = 오류
	@PostMapping("/recom")
	public int tipRecom(HttpSession session, @RequestParam("t_b_num") int t_b_num) throws Exception{
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return 3;
		}
		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_num(t_b_num);
		
		int recomResult = ts.recomUpdate(tDto);
		
		return recomResult;
	}
	// 1 = 성공 , 2 = 실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/reply/insert")
	public int replyInsert(HttpSession session, int t_b_num, String t_r_content) throws Exception{
		String email = (String)session.getAttribute("email");
		if(email == null) {
			return 3;
		}
		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_num(t_b_num);
		tDto.setT_r_content(t_r_content);
		
		int replyInsertResult = ts.replyInsert(tDto);
		
		return replyInsertResult;
	}
	
	@GetMapping("/reply/list")
	public List<TipDto> replyList(int t_b_num) throws Exception{
        
        List<TipDto> replyList = ts.getReplyList(t_b_num);
		
		return replyList;
	}
	
	@PostMapping("/reply/delete")
	public int replyDelete(HttpSession session, int t_r_num) throws Exception{
		log.info(t_r_num+"번 댓글 삭제 시작");
		String email = (String)session.getAttribute("email");
		TipDto repylInfo = ts.getReplyinfo(t_r_num);
		if(email.equals(repylInfo.getEmail())) {
			int deleteResult = ts.replyDelete(t_r_num);
			return deleteResult;
		}else{
			return 3;
		}
	}
	
	@GetMapping("/reply/match")
	public boolean replyMatch(HttpSession session, int t_r_num) throws Exception{
		log.info(t_r_num+"번 댓글 데이터 가져오기 시작");
		String email = (String)session.getAttribute("email");
		TipDto repylInfo = ts.getReplyinfo(t_r_num);
		return email.equals(repylInfo.getEmail());
	}
	
	
}
