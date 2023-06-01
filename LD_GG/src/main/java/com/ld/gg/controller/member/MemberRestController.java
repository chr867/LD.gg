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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.summoner.SummonerDto;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.PaymentService;
import com.ld.gg.userClass.SessionListener;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/member")
public class MemberRestController {
	@Autowired
	private MemberService ms;
	
    @Autowired
    private SessionListener sessionListener;
    
    @Autowired
    private PaymentService paymentService;
    
    @PostMapping("/logout")
    public ModelAndView logout(HttpSession session, HttpServletRequest request) throws Exception {
    	String referer = request.getHeader("Referer");
        String email = (String) session.getAttribute("email");
        if (email != null) {
            sessionListener.logout(email); // 세션 삭제
        }
        log.info("세션 무효화");
        session.invalidate(); // 세션 무효화
        return new ModelAndView("redirect:" + referer);
    }
	
	@PostMapping("/join")
	public ModelAndView join(MemberDto md) throws Exception {
		boolean result = ms.join(md);

		if (result) {
			paymentService.insert_point_0(md.getEmail()); //회원가입 성공시 포인트 테이블에 포인트 0으로 추가
			return new ModelAndView("redirect:/")
					.addObject("msg", "회원가입 성공")
					.addObject("check", 1);
		} else {
			return new ModelAndView("redirect:/member/join")
					.addObject("msg", "회원가입 실패");
		}
	}
	
	@GetMapping("/check_phone_num")
	public boolean check_phone_num(String phone_num) throws Exception {
		System.out.println(phone_num);
		boolean findResult = ms.findMemberPhoneNum(phone_num);
		return findResult;
	}

	@GetMapping("/check_email")
	public boolean check_email(String email) throws Exception {
		System.out.println(email);
		boolean findResult = ms.findMemberEmail(email);
		return findResult;
	}

	@GetMapping("/check_lol_account")
	public List<SummonerDto> check_lol_account(String summoner_name, String lol_account) throws Exception {
		System.out.println(summoner_name);
		
		boolean duplicateResult = ms.duplicateLolAccount(lol_account);
		if(duplicateResult) {
			List<SummonerDto> findResult = ms.findLolAccount(summoner_name);
			System.out.println(findResult);
			if (findResult.isEmpty()) {
				System.out.println("비어있음");
				return null;
			} else {
				return findResult;
			}
		}else {
			return null;
		}
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

	@PostMapping("/find_password")
	public String findPassword(String email, String phone_num) throws Exception {
		String password = ms.findPassword(email, phone_num);
		System.out.println("컨트롤러 반환결과" + password);
		return password;
	}
	
	@PostMapping("/change_password")
	public boolean changePassword(HttpSession session, String password, String changePw) throws Exception{
		String email = (String) session.getAttribute("email");
		boolean result = ms.changePassword(email,password,changePw);
		log.info("비밀번호 변경 컨트롤러 반환부 : "+result);
		return result;
	}

	@PostMapping("/drop_member")
	public boolean dropMember(String password, HttpSession session) throws Exception{
		String email = (String) session.getAttribute("email");
		boolean result = ms.dropMember(email,password);
		if(result) {
			log.info("탈퇴 완료");
			session.invalidate(); // 세션 무효화
			return true;
		}
		log.info("탈퇴 실패");
		return false;
	}
	
	@PostMapping("/change_usertype")
	public boolean changeUserType(String password, int user_type, HttpSession session) throws Exception{
		log.info("유저타입 변경 시작");
		String email = (String) session.getAttribute("email");
		boolean result = ms.changeUserType(email,password,user_type);
		log.info("회원전환 결과:"+result);
		if(result) {
			session.setAttribute("user_type", user_type);
		}
		return result;
	}
	
	@GetMapping("/check_login")
	public boolean checkLogin(HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (email != null) {
			log.info("로그인중 {}",email);
			return true;
		}else {
			log.info("비로그인중 {}",email);
			return false;	
		}
	}
}
