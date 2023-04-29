package com.ld.gg.controller.mentoringController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.mentoringService.MentorProfileService;

@Controller
@RequestMapping("/mentor")
public class MentoringController {
	
	@Autowired
	private MentorProfileService mtpService;
	
	@Autowired
	private MemberService ms;
	
	//멘토 찾기 페이지로 이동
	@GetMapping("/list")
    public String go_find_mentor() {
        return "mentoringView/mentorSearch";
    }
	
	//멘토 아이디를 입력해서 멘토 프로필 페이지로 이동
	@GetMapping("/profile/{mentor_email}")
    public String go_mentor_profile(@PathVariable String mentor_email, Model model) {
		MentorProfileDTO mtp = mtpService.select_by_email_mentor_profile(mentor_email);
		if (mtp!=null) {
			model.addAttribute("mentor_email", mtp.getMentor_email());
			model.addAttribute("class_info", mtp.getClass_info());
			model.addAttribute("specialized_champion", mtp.getSpecialized_champion());
			model.addAttribute("specialized_position", mtp.getSpecialized_position());
			model.addAttribute("contact_time", mtp.getContact_time());
			return "mentoringView/mentorInfo";
		}
		return null;
    }
	
	//멘토 프로필 작성 페이지로 이동
	@GetMapping("/write-profile")
    public String go_mentor_profile_edit(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		Integer user_type = (Integer)session.getAttribute("user_type");
		model.addAttribute("mentor_email", email);
		System.out.println(user_type);
		//if (user_type==2) {
		return "mentoringView/mentorProfileForm";
		//}
		//return null;
    }
}
