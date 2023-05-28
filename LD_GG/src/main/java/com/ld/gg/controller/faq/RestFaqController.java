package com.ld.gg.controller.faq;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ld.gg.dto.faq.CustomerInquiriesDTO;
import com.ld.gg.dto.faq.CustomerServiceDTO;
import com.ld.gg.service.FaqService;

@RestController
@RequestMapping(value = "/faq", produces = "text/html; charset=UTF-8")
public class RestFaqController {
	@Autowired
	private FaqService faqService;
	
	//모든 faq 가져오기
	@GetMapping("/get-all-faq")
	public String select_all_faq() throws JsonProcessingException {
		String faq_list_json = faqService.select_all_faq();
		return faq_list_json;
	}
	//faq 아이디로 faq 가져오기
	@GetMapping("/get-by-id-faq")
	public String select_by_id_faq(int faq_id) throws JsonProcessingException {
		String faq_json = faqService.select_by_id_faq(faq_id);
		return faq_json;
	}
	
	//모든 고객 질문 목록 가져오기
	@GetMapping("/get-all-ci")
	public String select_all_inquiries(@RequestParam int start) throws JsonProcessingException {
		String ci_dto_list_json = faqService.select_all_inquiries(start);
		return ci_dto_list_json;
	}
	//id로 고객 질문 가져오기
	@GetMapping("/get-by-id-ci/{id}")
	public String select_by_id_inquiries(@PathVariable("id") int inquiries_id) throws JsonProcessingException {
		String ci_dto_json = faqService.select_by_id_inquiries(inquiries_id);
		return ci_dto_json;
	}
	//keyword로 고객 질문 목록 가져오기
	@GetMapping("/get-by-keyword-ci")
	public String select_by_keyword_inquiries(@RequestParam String keyword, @RequestParam int start) throws JsonProcessingException {
		String ci_dto_list_json = faqService.select_by_keyword_inquiries(keyword,start);
		return ci_dto_list_json;
	}
	//이메일로 고객 질문 가져오기
	@PostMapping("/get-by-email-ci")
	public String select_by_email_inquiries(@RequestBody Map<String,String> customer_email_map) throws JsonProcessingException {
		String ci_dto_list_json = faqService.select_by_email_inquiries(customer_email_map);
		return ci_dto_list_json;
	}
	//고객 질문 등록
	@PostMapping("/save-ci")
	public void insert_inquiries(@RequestBody CustomerInquiriesDTO ci) {
		faqService.insert_inquiries(ci);
	}
	//고객 질문 수정
	@PutMapping("/update-ci")
	public void update_inquiries(@RequestBody CustomerInquiriesDTO ci) {
		faqService.update_inquiries(ci);
	}
	//고객 질문 삭제
	@DeleteMapping("/delete-ci")
	public void delete_inquiries(@RequestParam int inquiries_id) {
		faqService.delete_inquiries(inquiries_id);
	}
	
	//질문 아이디로 고객 응대 가져오기
	@GetMapping("/get-cs/{id}")
	public String select_by_id_customer_service(@PathVariable("id") int inquiries_id) throws JsonProcessingException {
		String cs_dto_json = faqService.select_by_id_customer_service(inquiries_id);
		return cs_dto_json;
	}
	//고객 응대 등록
	@PostMapping("/save-cs")
	public void insert_customer_service(@RequestBody CustomerServiceDTO cs) {
		System.out.println(cs);
		faqService.insert_customer_service(cs);
	}
	//고객 응대 수정
	@PutMapping("/update-cs")
	public void update_customer_service(@RequestBody CustomerServiceDTO cs) {
		faqService.update_customer_service(cs);
	}
	//고객 응대 삭제
	@DeleteMapping("/delete-cs")
	public void delete_customer_service(@RequestParam int cs_id) {
		faqService.delete_customer_service(cs_id);
	}

}
