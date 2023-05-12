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
		log.info("메이트레스트 컨트롤러 탔어용-상세글 리스트가져오기");
		List<MateDto> mList= ms.getMateList();
		
	    ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(mList);
		log.info(json);
		
		return json;
	}
	@GetMapping("/reply/list")
	public List<MateDto> getReplyList(int mate_id) throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용-리플가져오기");
		List<MateDto> mReplyList= ms.getReplyList(mate_id);
		return mReplyList;
	}
	
	
	// 1 = 성공 , 2 = 실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/reply/insert")
	public int mateReplyInsert(HttpSession session,int mate_id,String mate_r_content,String email) {
		log.info("메이트 레스트 컨트롤러 댓글 등록");
		String mate_apply = (String) session.getAttribute("email");
		log.info("mate_apply:"+mate_apply);
		if (mate_apply==null) {
			return 3;
		}
		MateDto mDto = new MateDto();
		mDto.setEmail(ms.getMateDetails(mate_id).getEmail());
		mDto.setMate_apply(mate_apply);
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
