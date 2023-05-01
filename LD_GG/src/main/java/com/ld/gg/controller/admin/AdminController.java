package com.ld.gg.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
}
