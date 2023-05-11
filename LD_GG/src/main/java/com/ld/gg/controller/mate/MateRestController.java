package com.ld.gg.controller.mate;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.MateDto;
import com.ld.gg.service.MateService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/mate")
public class MateRestController {
	@Autowired
	MateService ms;
	
	@GetMapping("/list.json")
	public String MateList() throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용");
		List<MateDto> mList= ms.getMateList();
		
	    ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(mList);
		log.info(json);
		
		return json;
	}
	// 1 = 성공 , 2 = 실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/reply/insert")
	public int mateReplyInsert(HttpSession session,int mate_id,String mate_r_content,String mate_apply) {
		log.info("리플 인썰트 탔어용");
		String email = (String) session.getAttribute("email");
		if (email==null) {
			return 3;
		}
		MateDto mDto = new MateDto();
		mDto.setEmail(email);
		mDto.setMate_id(mate_id);
		mDto.setMate_r_content(mate_r_content);
		int replyInsertResult=ms.mateReplyInsert(mDto);
		log.info("replyInsertResult"+replyInsertResult);	
		return replyInsertResult;
	}
	
/*	@GetMapping("/search.json")//상세페이지 제작후 만들기
	public String mateSearch(String keyword) {
		log.info("메이트레스트 서치 탔어용");
		
		}*/
		
		
		
	

}
