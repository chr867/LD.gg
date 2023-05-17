package com.ld.gg.controller.mate;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

	@RequestMapping("/")
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

	@GetMapping("/modify")
	public ModelAndView mateModify(@RequestParam int mate_id) throws Exception {
		log.info("메이트 수정 이동");
		MateDto mateModify = ms.getMateDetails(mate_id);
		ModelAndView mav =new ModelAndView("mate/modify");
		
		mav.addObject("title",mateModify.getMate_title());
		mav.addObject("content",mateModify.getMate_content());
		log.info("mateModify mav 값:"+mav);
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
		
	
		@PostMapping("/write_mateModify")
		public ModelAndView modifyMate(@RequestParam String mate_title,@RequestParam int mate_id, @RequestParam String mate_content, HttpSession session)
				throws Exception {
			log.info("메이트 글수정 완료 버튼 누름");
			String email = (String) session.getAttribute("email");
			log.info("이메일 정보: " + email);
			if (email == null) {
				// 로그인되어 있지 않으면 로그인 페이지로 이동
				log.info("로그인이 필요합니다.");
				return new ModelAndView("redirect:/");
			}
			MateDto mDto = new MateDto();
      
			//int mate_id = ms.getMateList();
			//int mate_id = ms.getMateList().get(0).getMate_id();
			mate_id=ms.getMateInfo(mate_id).getMate_id();
			log.info("모디파이."+mate_id);
			mDto.setMate_id(mate_id);
			mDto.setMate_title(mate_title);
			mDto.setMate_content(mate_content);
			log.info("메이트 글 수정 내용"+mDto);
			boolean isSuccess = ms.mateModify(mDto);
			log.info("메이트 글 수정 결과:"+isSuccess);
			if (isSuccess) {
				return new ModelAndView("redirect:/mate/");
			}else {
				ModelAndView mav = new ModelAndView("/mate/modify");
				mav.addObject("errorMsg", "글수정에 실패했습니다. 다시 시도해주세요");			
				mav.addObject("mate_id", mate_id);
				mav.addObject("title", mate_title);
				mav.addObject("content", mate_content);
				log.info("mav: " + mav.getModel().toString());
				return mav;
			}	
	}
		@PostMapping("/reply/modify")
		public ModelAndView replyMateModify(@RequestParam int mate_id,@RequestParam int mate_r_id,HttpSession session)
				throws Exception {
			log.info("메이트 선택 버튼 누름");
			String email = (String) session.getAttribute("email");
			log.info("이메일 정보: " + email);
			if (email == null) {
				// 로그인되어 있지 않으면 로그인 페이지로 이동
				log.info("로그인이 필요합니다.");
				return new ModelAndView("redirect:/");
			}
			MateDto mDto = new MateDto();
			mDto.setMate_r_id(mate_r_id);
			mDto.setMate_id(mate_id);
			log.info("메이트 선택 내용"+mDto);
			boolean isSuccess = ms.replyMateModify(mDto);
			log.info("메이트 선택 결과:"+isSuccess);
			if (isSuccess) {
				return new ModelAndView("redirect:/mate/");
			}else {
				log.info("isSuccess 메이트 선택 실패");
				return new ModelAndView("redirect:/");
			}	
		}
}
