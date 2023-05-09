package com.ld.gg.controller.faq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ld.gg.service.FaqService;


@Controller
@RequestMapping("/faq")
public class FaqContoroller {
	@Autowired
	private FaqService faqService;
	
	@GetMapping
	public String go_faq_list() {
		return "faqView/inquiriesList";
	}
	
	@GetMapping("/detail")
	public String go_faq_detail() {
		return "faqView/inquiriesDetails";
	}
	
	@GetMapping("/write")
	public String go_faq_write() {
		return "faqView/inquiriesWrite";
	}
	
	@GetMapping("/modify")
	public String go_faq_modify() {
		return "faqView/inquiriesModify";
	}

}
