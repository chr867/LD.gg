package com.ld.gg.controller.faq;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dto.MemberDto;


@Controller
@RequestMapping("/faq")
public class FaqContoroller {
	@Autowired
	private MemberDao mbdao;
	
	@GetMapping
	public ModelAndView go_inquiries_list(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		MemberDto mbdto = mbdao.getMemberInfo(email);
		return new ModelAndView("faqView/inquiriesList")
				.addObject("member", mbdto);
	}
	
	@GetMapping("/detail")
	public String go_inquiries_detail() {
		return "faqView/inquiriesDetails";
	}
	
	@GetMapping("/write")
	public String go_inquiries_write() {
		return "faqView/inquiriesWrite";
	}
	
	@GetMapping("/modify")
	public String go_inquiries_modify() {
		return "faqView/inquiriesModify";
	}

}
