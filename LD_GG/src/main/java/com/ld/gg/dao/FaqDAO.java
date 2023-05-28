package com.ld.gg.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.ld.gg.dto.faq.CustomerInquiriesDTO;
import com.ld.gg.dto.faq.CustomerServiceDTO;
import com.ld.gg.dto.faq.FaqDTO;

@Mapper
public interface FaqDAO {
	
	//모든 faq 가져오기
	List<FaqDTO> select_all_faq();
	//faq 아이디로 faq 가져오기
	FaqDTO select_by_id_faq(int faq_id);
	
	//keyword로 고객 질문 목록 가져오기
	List<CustomerInquiriesDTO> select_by_keyword_inquiries(@Param("keyword") String keyword, @Param("start") int start);
	//모든 고객 질문 가져오기
	List<CustomerInquiriesDTO> select_all_inquiries(int start);
	//이메일로 고객 질문 가져오기
	List<CustomerInquiriesDTO> select_by_email_inquiries(String customer_email);
	//아이디로 고객 질문 가져오기
	CustomerInquiriesDTO select_by_id_inquiries(int id);
	//고객 질문 등록
	void insert_inquiries(CustomerInquiriesDTO ci);
	//고객 질문 수정
	void update_inquiries(CustomerInquiriesDTO ci);
	//고객 질문 삭제
	void delete_inquiries(int inquiries_id);
	
	//질문 아이디로 고객 응대 가져오기
	CustomerServiceDTO select_by_id_customer_service(int inquiries_id);
	//고객 응대 등록
	void insert_customer_service(CustomerServiceDTO cs);
	//고객 응대 수정
	void update_customer_service(CustomerServiceDTO cs);
	//고객 응대 삭제
	void delete_customer_service(int cs_id);
	
}
