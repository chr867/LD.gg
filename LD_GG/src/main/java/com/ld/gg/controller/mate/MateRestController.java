package com.ld.gg.controller.mate;

import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	@GetMapping("/reply/select")
	public MateDto getReplySelect(int mate_id) throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용-선택 가져오기");
		log.info("메이트 아이디 "+mate_id);
		MateDto mDto= ms.getReplySelect(mate_id);
		log.info("메이트  선택 디티오"+mDto);
		return mDto;
	}
	@PostMapping("/bookmark")
	public MateDto getBookmark(String email) throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용-북마크 가져오기");
		log.info("메이트 email "+email);
		MateDto mDto= ms.getBookmark(email);
		log.info("메이트  북마크 디티오"+mDto);
		return mDto;
	}
	
	@GetMapping("/reply/list")
	public List<MateDto> getReplyList(int mate_id) throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용-리플가져오기");
		log.info("메이트 아이디 "+mate_id);
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
	// 1 = 성공 , 2 = 실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/delete")
	public  int deleteMate(@RequestParam int mate_id, HttpSession session)
			throws Exception {
		log.info("메이트 삭제 버튼 누름");
		String email = (String) session.getAttribute("email");
		log.info("이메일 정보: " + email);
		if (email == null) {
			// 로그인되어 있지 않으면 로그인 페이지로 이동
			log.info("로그인이 필요합니다.");

			return 3;
		}
		//int mate_id = ms.getMateList();
		int replyInsertResult = ms.mateDelete(mate_id);
		log.info("replyInsertResult"+replyInsertResult);	
		return replyInsertResult;
	}
	// 1 = 성공 , 2 = 실패, 3 = 이메일매칭 x, 4 = 오류
	@PostMapping("/reply/delete")
	public  int ReplyDeleteMate(@RequestParam int mate_id,@RequestParam int mate_r_id, HttpSession session)
			throws Exception {
		log.info("메이트 삭제 버튼 누름");
		String email = (String) session.getAttribute("email");
		log.info("이메일 정보: " + email);
		
		
		if (email == null) {
			// 로그인되어 있지 않으면 로그인 페이지로 이동
			log.info("로그인이 필요합니다.");
			
			return 3;
		}
		int replydeleteResult = ms.mateReplyDelete(mate_id,mate_r_id);
		log.info("replydeleteResult"+replydeleteResult);	
		return replydeleteResult;
	}
	@GetMapping("/search.json")
	public String mateSearch(String keyword) throws Exception {
		log.info("메이트 검색 진입");
        log.info(keyword);
        List<MateDto> searchList = ms.getSearchList(keyword);
        
        ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(searchList);
		
		return json;
	}
}
