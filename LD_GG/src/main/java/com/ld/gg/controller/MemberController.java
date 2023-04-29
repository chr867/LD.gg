package com.ld.gg.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@GetMapping("/check_phone_num")
	@ResponseBody
	public boolean check_phone_num(String phone_num) throws Exception {
		System.out.println(phone_num);
		boolean findResult = ms.findMemberPhoneNum(phone_num);
		return findResult;
	}

	@GetMapping("/check_email")
	@ResponseBody
	public boolean check_email(String email) throws Exception {
		System.out.println(email);
		boolean findResult = ms.findMemberEmail(email);
		return findResult;
	}

	@GetMapping("/check_lol_account")
	public @ResponseBody List<MemberDto> check_lol_account(String lol_account) throws Exception {
		System.out.println(lol_account);
		List<MemberDto> findResult = ms.findLolAccount(lol_account);
		System.out.println(findResult);
		if (findResult.isEmpty()) {
			System.out.println("비어있음");
			return null;
		} else {
			return findResult;
		}

	}

	@PostMapping("/join")
	public ModelAndView join(MemberDto md) throws Exception {

		boolean result = ms.join(md);

		if (result) {
			return new ModelAndView("redirect:/home").addObject("msg", "회원가입 성공").addObject("check", 1);
		} else {
			return new ModelAndView("redirect:/join").addObject("msg", "회원가입 실패");
		}
	}

	@PostMapping("/login")
	public ModelAndView login(MemberDto md, HttpSession session, RedirectAttributes ra) throws Exception {
		MemberDto member = ms.login(md);
		log.info("{}",member);
		System.out.println("로그인 반환 결과:"+member);
		if (member != null) {
			session.setAttribute("email", member.getEmail());
			session.setAttribute("lol_account", member.getLol_account());
			session.setAttribute("user_type", member.getUser_type());

			ra.addFlashAttribute("msg", "로그인 성공");
			return new ModelAndView("redirect:/testMain");
		}
		ra.addFlashAttribute("msg", "로그인 실패");
		ra.addFlashAttribute("check", 2);
		return new ModelAndView("redirect:/");
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

	@GetMapping("/findEmail")
	public String findEmail(Model model) {
		return "findEmail";
	}

	@GetMapping("/find_email")
	@ResponseBody
	public String find_email(String phone_num) throws Exception {
		String email = ms.findEmail(phone_num);
		if (email != null) {
			return email;
		}
		return null;
	}

	@GetMapping("/findPassword")
	public String moveFindPassword(Model model) {
		return "findPassword";
	}

	@PostMapping("/find_password")
	public @ResponseBody String findPassword(@RequestParam("email") String email,
			@RequestParam("phone_num") String phone_num) throws Exception {
		String password = ms.findPassword(email, phone_num);
		System.out.println("컨트롤러 반환결과" + password);
		return password;
	}
	
	@GetMapping("/changePassword")
	public String moveChangePassword(String email, String password) {
		return "changePassword";
	}
	
	@PostMapping("/change_password")
	@ResponseBody
	public boolean changePassword(String email, String password, String changePw) {
		boolean result = ms.changePassword(email,password,changePw);
		log.info("비밀번호 변경 컨트롤러 반환부 : "+result);
		return result;
	}
	@GetMapping("/dropMember")
	public String moveDropMember(Model model) {
		return "dropMember";
	}
	
	@PostMapping("/drop_member")
	@ResponseBody
	public boolean dropMember(String email, String password, HttpSession session) {
		boolean result = ms.dropMember(email,password);
		if(result) {
			log.info("탈퇴 완료");
			session.invalidate(); // 세션 무효화
			return true;
		}
		log.info("탈퇴 실패");
		return false;
	}
}
