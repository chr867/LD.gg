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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.service.MemberService;
import com.ld.gg.userClass.SessionListener;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService ms;
	
	private final SessionListener sl;

	@Autowired
	public MemberController(SessionListener sl) {
	    this.sl = sl;
	}

	
	@GetMapping("/join")
	public String goJoin(Model model) {
		return "/member/join";
	}
	
	@PostMapping("/login")
	public ModelAndView login(HttpServletRequest request, MemberDto md, HttpSession session, RedirectAttributes ra) throws Exception {
	    MemberDto member = ms.login(md);
	    SummonerDto sDto = ms.getSummonerIcon(member);
	    String referer = request.getHeader("Referer");
	    log.info("--------------SDTO 결과 !!!!{}", sDto);
	    log.info("{}", md);
	    log.info("--------------MDTO 결과 !!!!{}", member);
	    System.out.println("로그인 반환 결과:" + member);
	    if (member != null) {
	        session.setAttribute("email", member.getEmail());
	        session.setAttribute("lol_account", member.getLol_account());
	        session.setAttribute("user_type", member.getUser_type());
	        session.setAttribute("summoner_name", sDto.getSummoner_name());
	        session.setAttribute("summoner_icon", sDto.getProfile_icon_id());

	        sl.login(member.getEmail(), request);

	        ra.addFlashAttribute("msg", "로그인 성공");
	        return new ModelAndView("redirect:" + referer);
	    }
	    ra.addFlashAttribute("msg", "로그인 실패");
	    ra.addFlashAttribute("check", 2);
	    return new ModelAndView("redirect:" + referer);
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
	
	@GetMapping("/mypage")
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
	@GetMapping("/changeUserType")
	public String changeUserType() {
		return "/member/changeUserType";
	}
	
	
}
