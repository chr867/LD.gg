package com.ld.gg.controller.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService ms;

	@GetMapping("/join")
	public String goJoin(Model model) {
		return "/member/join";
	}
	
	@PostMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		if (session.getAttribute("email") != null) {
			session.invalidate(); // 세션 무효화
			return "redirect:/";
		} else {
			log.info("비로그인 중");
			return "redirect:/";
		}
	}
	
	@GetMapping("/testMain")
	public String goTestMain(Model model) {
		return "/member/testMain";
	}

	@GetMapping("/findEmail")
	public String goFindEmail(Model model) {
		return "/member/findEmail";
	}

	@GetMapping("/findPassword")
	public String goFindPassword(Model model) {
		return "/member/findPassword";
	}
	
	@GetMapping("/changePassword")
	public String goChangePassword(Model model) {
		return "/member/changePassword";
	}
	
	@GetMapping("/myPage")
	public String goMypage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		Integer user_type = (Integer)session.getAttribute("user_type");
		model.addAttribute("email", email);
		model.addAttribute("user_type", user_type);
		return "/member/myPage";
	}
	
	@GetMapping("/profile")
	public String goProfile() {
		return "/member/profile";
	}
	
	@GetMapping("/dropMember")
	public String goDropMember() {
		return "/member/dropMember";
	}
	
	@GetMapping("/rank")
	public String goMemberRank() {
		return "/member/rank";
	}
	
	
}
