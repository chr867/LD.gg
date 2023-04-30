package com.ld.gg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.service.Ex_service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	@Autowired
	private Ex_service es;
	
	@GetMapping("/")
	public String home(Model model) {
//		es.test();
		return "index";
	}
	
	//마이페이지로 이동
	@GetMapping("/mypage")
	public String go_mypage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		Integer user_type = (Integer)session.getAttribute("user_type");
		model.addAttribute("email", email);
		model.addAttribute("user_type", user_type);
		return "myPage";
	}
}
