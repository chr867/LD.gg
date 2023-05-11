package com.ld.gg.controller.mate;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dto.MateDto;
import com.ld.gg.service.MateService;
import com.mysql.cj.log.Log;

import lombok.extern.slf4j.Slf4j;

//mate dao mate_id,email,mate_content,mate_date,mate_title
@Slf4j
@Controller
@RequestMapping("/mate")
public class MateController {
	@Autowired
	private MateService ms;

	@GetMapping("/")
	public String goMateList() throws Exception {
		log.info("메이트 게시판 이동.");
		return "/mate/list";// 구현중
	}

	@GetMapping("/write")
	public String goMateWrite() throws Exception {
		log.info("메이트 글쓰기 이동.");
		return "/mate/write";
	}
	@GetMapping("/details")
	public ModelAndView mateDetails(@RequestParam int mate_id) throws Exception {
	log.info("메이트 상세 보기 이동");
	MateDto MateDetails = ms.getMateDetails(mate_id);
	ModelAndView mav =new ModelAndView("mate/details");
	mav.addObject("MateDetails",MateDetails);
	log.info("mav 값:"+mav);
	return mav;
		
	}

	@PostMapping("/write_mate")
	public ModelAndView writeMate(@RequestParam String mate_title, @RequestParam String mate_content, HttpSession session)
			throws Exception {
		log.info("메이트 글작성 완료 버튼 누름");
		String email = (String) session.getAttribute("email");
		log.info("이메일 정보: " + email);
		if (email == null) {
			// 로그인되어 있지 않으면 로그인 페이지로 이동
			log.info("로그인이 필요합니다.");
			return new ModelAndView("redirect:/");
		}
		MateDto mDto = new MateDto();
		mDto.setEmail(email);
		mDto.setMate_title(mate_title);
		mDto.setMate_content(mate_content);
		log.info("메이트 글내용"+mDto);
		boolean isSuccess = ms.mateWrite(mDto);
		log.info("메이트 인서트 결과:"+isSuccess);
		if (isSuccess) {
			return new ModelAndView("redirect:/mate/");
		}else {
			ModelAndView mav = new ModelAndView("/mate/write");
			mav.addObject("errorMsg", "글쓰기에 실패했습니다. 다시 시도해주세요");
			mav.addObject("title", mate_title);
			mav.addObject("content", mate_content);
			log.info("mav: " + mav.getModel().toString());
			return mav;
		}
		
	
	}
}