package com.ld.gg.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.NoticeDto;
import com.ld.gg.service.AdminService;

@Controller
@RequestMapping("/userinterface")
public class AdminController {
	@Autowired
	AdminService as;
	
	@GetMapping("/notice")
	public String go_notice() {
		return "notice";
	}
	
	@GetMapping("/notice/detail")
	public String deatil_notice(Model model,int t_b_num) throws Exception{
		as.increase_views(t_b_num);
		NoticeDto notice = as.get_notice_detail(t_b_num);
		model.addAttribute("notice", notice);
		
		return "notice_detail";
	}
	
	@GetMapping("/notice/write")
	public String write_notice() throws Exception{
		return "notice_write";
	}
	
	@PostMapping("/notice/write.do")
	public String write_notice_do(@RequestParam String t_b_title, @RequestParam String t_b_content) throws Exception{
		NoticeDto nd = new NoticeDto();
		nd.setT_b_title(t_b_title);
		nd.setT_b_content(t_b_content);
		
		boolean result = as.write_notice(nd);
		String tmp = null;
		
		if(result) {
			tmp = "notice";
		}else {
			tmp = "notice_write";
		}
		
		return tmp;
	}
	
}
