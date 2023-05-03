package com.ld.gg.controller.mentoringController;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.mentoringService.MentorProfileService;

@Controller
@RequestMapping("/mentor")
public class MentoringController {
	
	@Autowired
	private MentorProfileService mtpService;
	@Autowired
	private MemberService mbService;
	@Autowired
	private MemberDao mbdao;
	
	
	
	//마이멘토링 페이지로 이동
	@GetMapping("/my-mentoring")
	public ModelAndView go_my_mentoring(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		return new ModelAndView("mentoringView/myMentoring")
				.addObject("member", mbdto);
	}
	
	//맞춤 멘토 페이지로 이동
	@GetMapping("/custom-mentor")
	public ModelAndView go_custom_mentor(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		List<TagListDTO> tagdto = mtpService.select_all_tag();
		return new ModelAndView("mentoringView/customMentor") 
				.addObject("tag_list", tagdto)
				.addObject("member", mbdto);
	}
	
	//멘토 찾기 페이지로 이동
	@GetMapping("/list")
    public String go_find_mentor() {
        return "mentoringView/mentorSearch";
    }
	
	//멘토 아이디를 입력해서 멘토 프로필 페이지로 이동
	@GetMapping("/profile/{lol_account}")
    public ModelAndView go_mentor_profile(@PathVariable String lol_account, HttpServletRequest request) {
		HttpSession session = request.getSession(); // 현재 접속중인 회원의 아이디 확인
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		List<MemberDto> mbList = mbService.findLolAccount(lol_account);
		String mentor_email = mbList.get(0).getEmail();
		List<MentorClassDTO> mentor_class_list = mtpService.select_by_email_mentor_class(mentor_email);
		MentorProfileDTO mtp = mtpService.select_by_email_mentor_profile(mentor_email);
		return new ModelAndView("mentoringView/mentorInfo")
				.addObject("mentor_profile", mtp)
				.addObject("class_list", mentor_class_list)
				.addObject("mentor", mbList.get(0))
				.addObject("member", mbdto);
    }
	
	//멘토 프로필 작성 페이지로 이동
	@GetMapping("/write-profile")
    public ModelAndView go_mentor_profile_edit(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		Integer user_type = (Integer)session.getAttribute("user_type");
		MentorProfileDTO mtp = mtpService.select_by_email_mentor_profile(email);
		MemberDto mbdto = mbdao.getMemberInfo(email);
		List<MentorClassDTO> mentor_class_list = mtpService.select_by_email_mentor_class(email);
		List<TagListDTO> tagList = mtpService.select_all_tag();
		if (user_type==2) { //멘토 회원인 경우에만 접근 허용
			if(mtp == null) { //프로필이 없는 경우 빈 프로필 생성
				mtpService.insert_mentor_profile(email);
				return new ModelAndView("mentoringView/mentorProfileForm") 
						.addObject("mentor_profile", mtp)
						.addObject("tag_list", tagList)
						.addObject("class_list", mentor_class_list)
						.addObject("member", mbdto);
			}else {
			return new ModelAndView("mentoringView/mentorProfileForm") 
					.addObject("mentor_profile", mtp)
					.addObject("tag_list", tagList)
					.addObject("class_list", mentor_class_list)
					.addObject("member", mbdto);
			}
		}else {
			return new ModelAndView("redirect:/member/profile");
		}
    }
}
