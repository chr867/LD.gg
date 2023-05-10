package com.ld.gg.controller.tip;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dto.TipDto;
import com.ld.gg.service.TipService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tip")
public class TipController {
	@Autowired
	private TipService ts;
	
	@GetMapping("/")
	public String goTipList(Model model) throws Exception{
		return "/tip/list";
	}
	
	@GetMapping("/details")
	public ModelAndView tipDetails(@RequestParam("t_b_num") int t_b_num) throws Exception{
		TipDto tipDetails = ts.getTipDetails(t_b_num);
		
		//페이지 로드시 조회수 1씩 증가 
		int t_b_views = tipDetails.getT_b_views() + 1; 
		log.info("조회수 : "+t_b_views);
		tipDetails.setT_b_views(t_b_views); 
	    ts.updateView(tipDetails); 
	    
		ModelAndView mav = new ModelAndView("tip/details");
		mav.addObject("tipDetails",tipDetails);
		return mav;
	}
	
	@GetMapping("/write")
	public String goTipWrite(Model model) throws Exception{
		return "/tip/write";
	}
	
	@PostMapping("/write_tip")
	public ModelAndView writeTip(@RequestParam String t_b_title, @RequestParam String t_b_content,
			@RequestParam int champion_id, HttpSession session) throws Exception{
		String email = (String)session.getAttribute("email");
		log.info("이메일 정보: "+email);
		if (email == null) {
			// 로그인되어 있지 않으면 로그인 페이지로 이동
			log.info("로그인이 필요합니다.");
			return new ModelAndView("redirect:/");
		}

		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_title(t_b_title);
		tDto.setT_b_content(t_b_content);
		tDto.setChampion_id(champion_id);
		log.info("공략 글내용"+tDto);
		boolean isSuccess = ts.tipWrite(tDto);
		log.info("공략 인서트 결과:"+isSuccess);
		if (isSuccess) {
			// 글쓰기 성공시 게시판 목록 페이지로 이동
			return new ModelAndView("redirect:/tip/");
		} else {
			// 글쓰기 실패시 글쓰기 페이지로 이동
			ModelAndView mav = new ModelAndView("tip/write");
			mav.addObject("errorMsg", "글쓰기에 실패했습니다.");
			mav.addObject("title", t_b_title);
			mav.addObject("content", t_b_content);
			mav.addObject("champion", champion_id);
			return mav;
		}
	}
	
	@GetMapping("/modify")
	public ModelAndView goTipModify(@RequestParam("t_b_num")int t_b_num, HttpSession session) throws Exception{
		log.info("글수정 기능 글번호 :"+t_b_num);
		String email = (String)session.getAttribute("email");
		TipDto tipInfo = ts.getTipinfo(t_b_num);
		if(email.equals(tipInfo.getEmail())) {
			ModelAndView mav = new ModelAndView("/tip/modify");
			mav.addObject("num", tipInfo.getT_b_num());
			mav.addObject("title", tipInfo.getT_b_title());
			mav.addObject("content", tipInfo.getT_b_content());
			mav.addObject("champion", tipInfo.getChampion_id());
			return mav;
		}else {
			return new ModelAndView("/tip/").addObject("msg","글 수정페이지 이동 실패");
		}
	}
	
	@PostMapping("/modify_tip")
	public ModelAndView modifyTip(@RequestParam int t_b_num,
            @RequestParam String t_b_title,
            @RequestParam String t_b_content,
            @RequestParam int champion_id,
            HttpSession session) throws Exception{
		
		String email = (String)session.getAttribute("email");
		
		TipDto tDto = new TipDto();
		tDto.setEmail(email);
		tDto.setT_b_num(t_b_num);
		tDto.setT_b_title(t_b_title);
		tDto.setT_b_content(t_b_content);
		tDto.setChampion_id(champion_id);
		log.info("공략 글내용"+tDto);
		boolean success = ts.ModifyTip(tDto);
		log.info("공략 인서트 결과:"+success);
		if (success) {
			// 글쓰기 성공시 게시판 목록 페이지로 이동
			return new ModelAndView("redirect:/tip/details?t_b_num=" + t_b_num);
		} else {
			// 글쓰기 실패시 글쓰기 페이지로 이동
			ModelAndView mav = new ModelAndView("/tip/modify?t_b_num=" + t_b_num);
			mav.addObject("errorMsg", "글쓰기에 실패했습니다.");
			mav.addObject("num", t_b_num);
			mav.addObject("title", t_b_title);
			mav.addObject("content", t_b_content);
			mav.addObject("champion", champion_id);
			return mav;
		}
	}
	
	}
