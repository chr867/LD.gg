package com.ld.gg.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
