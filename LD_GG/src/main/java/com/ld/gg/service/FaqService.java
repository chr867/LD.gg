package com.ld.gg.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.ld.gg.dao.FaqDAO;
import com.ld.gg.dto.faq.CustomerInquiriesDTO;
import com.ld.gg.dto.faq.CustomerServiceDTO;
import com.ld.gg.dto.faq.FaqDTO;

@Service
public class FaqService {

	@Autowired
	private FaqDAO faqdao;
	
	//모든 faq 가져오기
	public String select_all_faq() throws JsonProcessingException {
		List<FaqDTO> faq_dto_list = faqdao.select_all_faq();
		ObjectMapper objectMapper = new ObjectMapper();
		String faq_dto_list_json = objectMapper.writeValueAsString(faq_dto_list);
		return faq_dto_list_json;
	}
	//faq 아이디로 faq 가져오기
	public String select_by_id_faq(int faq_id) throws JsonProcessingException {
		FaqDTO faqdto = faqdao.select_by_id_faq(faq_id);
		ObjectMapper objectMapper = new ObjectMapper();
		String faq_dto_json = objectMapper.writeValueAsString(faqdto);
		return faq_dto_json;
	}
	
	//keyword로 고객 질문 목록 가져오기
	public String select_by_keyword_inquiries(String keyword) throws JsonProcessingException {
		List<CustomerInquiriesDTO> ci_dto_list = faqdao.select_by_keyword_inquiries(keyword);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		String ci_dto_list_json = objectMapper.writeValueAsString(ci_dto_list);
		return ci_dto_list_json;
	}
	//모든 고객 질문 가져오기
	public String select_all_inquiries() throws JsonProcessingException {
		List<CustomerInquiriesDTO> ci_dto_list = faqdao.select_all_inquiries();
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		String ci_dto_list_json = objectMapper.writeValueAsString(ci_dto_list);
		return ci_dto_list_json;
	}
	public String select_by_id_inquiries(int id) throws JsonProcessingException {
		CustomerInquiriesDTO ci_dto = faqdao.select_by_id_inquiries(id);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		String ci_dto_json = objectMapper.writeValueAsString(ci_dto);
		return ci_dto_json;
	}
	//이메일로 고객 질문 가져오기
	public String select_by_email_inquiries(Map<String,String> customer_email_map) throws JsonProcessingException {
		String customer_email = customer_email_map.get("customer_email");
		List<CustomerInquiriesDTO> ci_dto_list = faqdao.select_by_email_inquiries(customer_email);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		String ci_dto_list_json = objectMapper.writeValueAsString(ci_dto_list);
		return ci_dto_list_json;
	}
	//고객 질문 등록
	public void insert_inquiries(CustomerInquiriesDTO ci) {
		faqdao.insert_inquiries(ci);
	}
	//고객 질문 수정
	public void update_inquiries(CustomerInquiriesDTO ci) {
		faqdao.update_inquiries(ci);
	}
	//고객 질문 삭제
	public void delete_inquiries(int inquiries_id) {
		faqdao.delete_inquiries(inquiries_id);
	}
	
	//질문 아이디로 고객 응대 가져오기
	public String select_by_id_customer_service(int inquiries_id) throws JsonProcessingException {
		CustomerServiceDTO cs_dto = faqdao.select_by_id_customer_service(inquiries_id);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		String cs_dto_json = objectMapper.writeValueAsString(cs_dto);
		return cs_dto_json;
	}
	//고객 응대 등록
	public void insert_customer_service(CustomerServiceDTO cs) {
		faqdao.insert_customer_service(cs);
	}
	//고객 응대 수정
	public void update_customer_service(CustomerServiceDTO cs) {
		faqdao.update_customer_service(cs);
	}
	//고객 응대 삭제
	public void delete_customer_service(int cs_id) {
		faqdao.delete_customer_service(cs_id);
	}
	
	
	

}
