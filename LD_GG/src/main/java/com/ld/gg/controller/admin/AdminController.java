package com.ld.gg.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.admin.NoticeDto;

import com.ld.gg.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/userinterface")
public class AdminController {
	@Autowired
	AdminService as;
	
	@GetMapping("/notice")
	public String go_notice() {
		return "/notice/notice";
	}
	
	@GetMapping("/notice/detail")
	public String deatil_notice(Model model, int t_b_num) throws Exception{
		as.increase_views(t_b_num);
		NoticeDto notice = as.get_notice_detail(t_b_num);
		model.addAttribute("notice", notice);
		
		return "/notice/notice_detail";
	}
	
	@GetMapping("/notice/write")
	public String write_notice() throws Exception{
		return "/notice/notice_write";
	}
	
	@PostMapping("/notice/write.do")
	public String write_notice_do(@RequestParam String t_b_title, @RequestParam String t_b_content) throws Exception{
		t_b_content = t_b_content.replaceAll("<p[^>]*>|<\\/p[^>]*>", "");
		log.info("t_b_content : {}", t_b_content);
		
		NoticeDto nd = new NoticeDto();
		nd.setT_b_title(t_b_title);
		nd.setT_b_content(t_b_content);
		
		boolean result = as.write_notice(nd);
		String tmp = null;
		
		if(result) {
			tmp = "redirect:/userinterface/admin";
		}else {
			tmp = "redirect:/userinterface/notice/notice_write";
		}
		
		return tmp;
	}
		
	@RequestMapping("/notice/modify")
	public String notice_modify(Model model, Integer t_b_num) {
		NoticeDto nd = as.get_notice_detail(t_b_num);
		model.addAttribute("nd", nd);
		
		return "/notice/notice_modify";
	}
	
	@RequestMapping("/notice/modify.do")
	public String notice_modify_do(RedirectAttributes attribute, int t_b_num, String t_b_title, String t_b_content) {
		NoticeDto nd = new NoticeDto();
		nd.setT_b_num(t_b_num).setT_b_title(t_b_title).setT_b_content(t_b_content);
		
		Boolean b_result = as.modify_notice(nd);
		String s_result = null;
		
		if(b_result) {
			s_result = "redirect:/userinterface/notice";
			attribute.addFlashAttribute("msg", "수정 완료");
		}else {
			s_result = "redirect:/userinterface/notice/modify";
			attribute.addFlashAttribute("msg", "수정 실패");
		}

		return s_result;
	}
	
	@GetMapping("/admin")
	public String goAdPage() {
		return "/admin/adminPage";
	}
	

	@GetMapping("/ad/management")
	public String goAbMangement() {
		return "/admin/adManagement";
	}
	
	@GetMapping("/member/management")
	public String goMbMangement() {
		return "/admin/mbManagement";
	}
}
