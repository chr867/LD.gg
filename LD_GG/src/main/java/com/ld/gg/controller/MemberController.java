package com.ld.gg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.service.MemberService;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService ms;

	@GetMapping("/join")
	public String join_page(Model model) {
		return "join";
	}
	
	@GetMapping("/testMain")
	public String test_main(Model model) {
		return "testMain";
	}

	@PostMapping("/join")
	public ModelAndView join(MemberDto md) {

		boolean result = ms.join(md);

		if (result) {
			return new ModelAndView("home").addObject("msg", "회원가입 성공").addObject("check", 1);
		} else {
			return new ModelAndView("join").addObject("msg", "회원가입 실패");
		}
	}
	
	@PostMapping(value = "/login")
	public ModelAndView login(MemberDto md, HttpSession session) {
		MemberDto member = ms.login(md);

		if(member != null) {
			session.setAttribute("email", md.getEmail());
			session.setAttribute("lol_account", md.getLol_account());
			session.setAttribute("user_type", md.getUser_type());
			return new ModelAndView("testMain").addObject("msg", "로그인 성공");
		}
		return new ModelAndView("testMain").addObject("msg", "로그인 실패").addObject("check", 1);

	}
}
