package com.ld.gg.controller.mentoringController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.champ.Champ_default;
import com.ld.gg.dto.mentoringdto.CustomMentorDTO;
import com.ld.gg.dto.mentoringdto.LikeMentorDTO;
import com.ld.gg.dto.mentoringdto.MentiTagDTO;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorReviewDTO;
import com.ld.gg.dto.mentoringdto.MentorTagDTO;
import com.ld.gg.dto.mentoringdto.MyMentoringDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;
import com.ld.gg.dto.payment.PaymentDto;
import com.ld.gg.dto.payment.TransactionHistoryDTO;
import com.ld.gg.dto.mentoringdto.EstimateDTO;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.PaymentService;
import com.ld.gg.service.mentoringService.MentorProfileService;

import oracle.jdbc.proxy.annotation.Post;

@RestController
@RequestMapping(value = "/mentor", produces = "text/html; charset=UTF-8")
public class RestMentoringController {
	
	@Autowired
	private MentorProfileService mtpService;
	@Autowired
	private MemberDao mbdao;
	@Autowired
	private MemberService mbService;
	@Autowired
	private PaymentService ps;
	
	//모든 챔피언 이름 가져오기
	@GetMapping("/get-all-champ")
	public String select_all_champ() throws JsonProcessingException {
		String champ_name_list_json = mtpService.select_all_champ();
		return champ_name_list_json;
	}
	
	//챔피언 아이디로 챔피언 이름 가져오기
	@GetMapping("/get-champ-name-by-id")
	public String select_by_id_champ(@RequestParam int id) throws JsonProcessingException {
		String champ_name = mtpService.select_by_id_champ(id);
		return champ_name;
	}
	
	//리뷰어 이메일로 내가 쓴 리뷰 가져오기
	@PostMapping("/get-review-by-reviewer")
	public String select_by_reviewer_email_mentor_review(@RequestBody Map<String,String> reviewer_email) throws JsonProcessingException {
		String mentor_review_list = mtpService.select_by_reviewer_email_mentor_review(reviewer_email);
		return mentor_review_list;
	}
	
	//멘토 이메일로 나에게 달린 리뷰 가져오기
	@PostMapping("/get-review-for-me")
	public String select_by_mentor_email_mentor_review(@RequestBody Map<String,String> reviewer_email) throws JsonProcessingException {
		String mentor_review_list = mtpService.select_by_mentor_email_mentor_review(reviewer_email);
		return mentor_review_list;
	}
	
	//리뷰 생성
	@PostMapping("/save-review")
	public void insert_mentor_review(@RequestBody MentorReviewDTO mentor_review_dto) {
		mtpService.insert_mentor_review(mentor_review_dto);
	}
	
	//리뷰 삭제
	@DeleteMapping("/delete-review")
	public void insert_mentor_review(@RequestBody Map<String, Integer> review_num) {
		mtpService.delete_mentor_review(review_num);
	}
	
	//이메일로 찜한 멘토 목록 가져오기
	@PostMapping("/get-like-mentor")
	public String select_by_email_like_mentor(@RequestBody Map<String, String> emailmap) throws JsonProcessingException{
		String like_mentor_list_json = mtpService.select_by_email_like_mentor(emailmap);
		return like_mentor_list_json;
	}
	
	//찜한 멘토 추가
	@PostMapping("/insert-like-mentor")
	public void insert_like_mentor(@RequestBody LikeMentorDTO like_mentor_dto) {
		mtpService.insert_like_mentor(like_mentor_dto);
	}
	
	//찜한 멘토 삭제
	@Transactional
	@DeleteMapping("/delete-like-mentor")
	public void delete_like_mentor(@RequestBody LikeMentorDTO like_mentor_dto) {
		mtpService.delete_like_mentor(like_mentor_dto);
	}
	
	//세션 정보 체크
	@GetMapping("/check-session")
	public ResponseEntity<Map<String, Object>> checkSession(HttpServletRequest request) {
	    HttpSession session = request.getSession(false); // 현재 세션이 없으면 null 반환
	    if (session != null && session.getAttribute("email") != null) {
	        String email = (String) session.getAttribute("email"); // 세션에서 email 정보 가져오기
	        Map<String, Object> response = new HashMap<>();
	        response.put("isLoggedIn", true);
	        response.put("email", email);
	        return ResponseEntity.ok()
	                .contentType(MediaType.APPLICATION_JSON)
	                .body(response);
	    } else {
	        Map<String, Object> response = new HashMap<>();
	        response.put("isLoggedIn", false);
	        return ResponseEntity.ok()
	                .contentType(MediaType.APPLICATION_JSON)
	                .body(response);
	    }
	}
	
	//내 이메일로 나의 멘토링 신청 내역 가져오기
	@PostMapping("/get-mentoring-history")
	public String select_by_email_my_mentoring(@RequestBody Map<String,String> emailMap) throws JsonProcessingException{
		String my_mt_list_json = mtpService.select_by_email_my_mentoring(emailMap);
		return my_mt_list_json;
	}
	//멘토 이메일로 나에게 수강신청한 멘티 내역 가져오기
	@PostMapping("/get-request-history")
	public String select_by_mentor_email_my_mentoring(@RequestBody Map<String,String> emailMap) throws JsonProcessingException{
		String my_mt_list_json = mtpService.select_by_mentor_email_my_mentoring(emailMap);
		return my_mt_list_json;
	}
	//멘토링 내역 수정
	@PutMapping("/update-mentoring-history")
	public void update_my_mentoring(@RequestBody MyMentoringDTO my_mt_dto) {
		mtpService.update_my_mentoring(my_mt_dto);
	}
	
	//멘토링 내역 추가
	@PostMapping("/save-mentoring-history")
	public void insert_my_mentoring(@RequestBody MyMentoringDTO my_mt_dto) {
		mtpService.insert_my_mentoring(my_mt_dto);
	}
	//멘토링 내역 삭제
	@DeleteMapping("/delete-mentoring-history")
	public void delete_my_mentoring(@RequestBody MyMentoringDTO my_mt_dto) {
		mtpService.delete_my_mentoring(my_mt_dto);
	}
	//멘티 소환사명 받아서 멘토링 내역 삭제
	@DeleteMapping("/reject-mentoring-history")
	public void reject_my_mentoring(@RequestBody MyMentoringDTO my_mt_dto) {
		mtpService.reject_my_mentoring(my_mt_dto);
	}
	
	//멘토링 내역 환불
	@Transactional
	@DeleteMapping("/refund-mentoring-history")
	public void refund_my_mentoring(@RequestBody MyMentoringDTO my_mt_dto) {
		mtpService.delete_my_mentoring(my_mt_dto);
		//환불 하는 메서드 추가해야함~~~~~~~~~
		//환불 하는 메서드 추가해야함~~~~~~~~~
		//환불 하는 메서드 추가해야함~~~~~~~~~
	}
	
	//보낸 견적 내역 가져오기
	@GetMapping("/get-sent-estimate")
	public String select_by_mentor_email_estimate(HttpServletRequest request) throws JsonProcessingException{
		HttpSession session = request.getSession();
		String mentor_email = (String)session.getAttribute("email");
		List<EstimateDTO> estList = mtpService.select_by_mentor_email_estimate(mentor_email);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String estList_json = objectMapper.writeValueAsString(estList);
		return estList_json;
	}
	//받은 견적 내역 가져오기
	@GetMapping("/get-received-estimate")
	public String select_by_menti_email_estimate(HttpServletRequest request) throws JsonProcessingException{
		HttpSession session = request.getSession();
		String menti_email = (String)session.getAttribute("email");
		List<EstimateDTO> estList = mtpService.select_by_menti_email_estimate(menti_email);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String estList_json = objectMapper.writeValueAsString(estList);
		return estList_json;
	}
	
	//견적 내용을 받아서 견적 내역 저장
	@PostMapping("/save-estimate")
	public void insert_estimate(@RequestBody EstimateDTO estdto) {
		mtpService.insert_estimate(estdto);
	}
	
	//견적서 아이디로 견적 내용 삭제
	@DeleteMapping("/delete-estimate")
	public void delete_estimate(@RequestBody Map<String , Integer> estid){
		mtpService.delete_estimate(estid);
	}
	
	//나와 잘 맞는 멘티 추천
	@GetMapping("/recom-menti")
	public String recom_menti(HttpServletRequest request) throws JsonProcessingException{
		HttpSession session = request.getSession();
		String mentor_email = (String)session.getAttribute("email");
		List<CustomMentorDTO> cmList = mtpService.recom_menti(mentor_email);
		ObjectMapper objectMapper = new ObjectMapper();
		String cmList_json = objectMapper.writeValueAsString(cmList);
		return cmList_json;
	}
	
	//맞춤멘토 추천
	@GetMapping("/recom-mentor")
	public String recom_mentor(HttpServletRequest request) throws JsonProcessingException{
		HttpSession session = request.getSession();
		String menti_email = (String)session.getAttribute("email");
		List<MentorProfileDTO> mtpList = mtpService.recom_mentor(menti_email);
		ObjectMapper objectMapper = new ObjectMapper();
		String mtpList_json = objectMapper.writeValueAsString(mtpList);
		return mtpList_json;
	}
	
	//맞춤멘토 멘티 태그 저장
	@PostMapping("/save-menti-tag")
	@Transactional
	public void save_menti_tag(@RequestBody List<MentiTagDTO> menti_tag_list) {
		String menti_email = menti_tag_list.get(0).getMenti_email();
		mtpService.delete_menti_tag(menti_email);
		mtpService.insert_menti_tag(menti_tag_list);
	}
	
	//목표 태그 가져오기
	@GetMapping("/get-target-tag")
	public String select_taget_tag() throws JsonProcessingException {
		String taget_tag_list = mtpService.select_taget_tag();
		return taget_tag_list;
	}
	//수업방식 태그 가져오기
	@GetMapping("/get-class-method-tag")
	public String select_class_method_tag() throws JsonProcessingException {
		String class_method_tag_list = mtpService.select_class_method_tag();
		return class_method_tag_list;
	}
	//스타일 태그 가져오기
	@GetMapping("/get-style-tag")
	public String select_style_tag() throws JsonProcessingException {
		String style_tag_list = mtpService.select_style_tag();
		return style_tag_list;
	}
	//스타일2 태그 가져오기
	@GetMapping("/get-style2-tag")
	public String select_style2_tag() throws JsonProcessingException {
		String style2_tag_list = mtpService.select_style2_tag();
		return style2_tag_list;
	}
	//경력 태그 가져오기
	@GetMapping("/get-careers-tag")
	public String select_careers_tag() throws JsonProcessingException {
		String careers_tag_list = mtpService.select_careers_tag();
		return careers_tag_list;
	}
	
	//맞춤멘토 객체 받아서 업데이트
	@PostMapping("/save-custom-mentor")
	@Transactional
	public void save_custom_mentor(@RequestBody CustomMentorDTO custom_mentor) {
		String menti_email = custom_mentor.getMenti_email();
		mtpService.delete_custom_mentor(menti_email);
		mtpService.insert_custom_mentor(custom_mentor);
	}
	
	//이메일로 멘토 클래스 가져오기
	@GetMapping("/select-mentor-class")
	public String select_by_email_mentor_class(@RequestParam String lol_account) throws JsonProcessingException{
		List<MemberDto> mbdto = mbService.findLolAccount(lol_account);
		String email = mbdto.get(0).getEmail();
		List<MentorClassDTO> class_list = mtpService.select_by_email_mentor_class(email);
		ObjectMapper objectMapper = new ObjectMapper();
		String class_List_json = objectMapper.writeValueAsString(class_list);
		return class_List_json;
	}
	// 클래스 아이디로 멘토 클래스 정보 가져오기
	@GetMapping("/select-by-id-mentor-class")
	public String select_by_id_mentor_class(@RequestParam int class_id) throws JsonProcessingException {
		String mentor_class_json = mtpService.select_by_id_mentor_class(class_id);
		return mentor_class_json;
	}
	//멘토 클래스 인서트
	@PostMapping("/insert-mentor-class")
	public void insert_mentor_class(@RequestBody MentorClassDTO mentor_class_dto) {
		mtpService.insert_mentor_class(mentor_class_dto);
	}
	//멘토 클래스 업데이트
	@PutMapping("/update-mentor-class")
	public void update_mentor_class(@RequestBody MentorClassDTO mentor_class_dto) {
		mtpService.update_mentor_class(mentor_class_dto);
	}
	//멘토 클래스 삭제
	@DeleteMapping("/delete-mentor-class")
	public void delete_mentor_class(@RequestBody int class_id) {
		mtpService.delete_mentor_class(class_id);
	}
	
	//멘토 회원 목록 가져오기
	@GetMapping("/find-mentor")
	public String select_all_mentor_profile() throws JsonProcessingException{
		List<MentorProfileDTO> mtpList = mtpService.select_all_mentor_profiles();
		ObjectMapper objectMapper = new ObjectMapper();
		Iterator<MentorProfileDTO> iterator = mtpList.iterator();
		List<String> lol_name_list = new ArrayList<>();
		while (iterator.hasNext()) {
			MentorProfileDTO mtp = iterator.next();
		    String mentor_email = mtp.getMentor_email(); // mentor_email 異붿텧
		    MemberDto mbdto = mbdao.getMemberInfo(mentor_email);
		    lol_name_list.add(mbdto.getLol_account());
		}
		String mtpListjson = objectMapper.writeValueAsString(lol_name_list);
		return mtpListjson;
	}
	
	//일반 회원이 멘토회원으로 전환 할때 멘토 프로필 추가
	@PostMapping("/insert-mentor-list")
	public void insert_mentor_profile(@RequestBody Map<String, String> email){
		String mentor_email = email.get("mentor_email");
		mtpService.insert_mentor_profile(mentor_email);
	}
	
	//회원정보에 회원타입이 멘토인 사람을 멘토프로필에 인서트
	@PostMapping("/renewal-mentor-list")
	public void renewal_mentor_profile(){
		mtpService.renewal_mentor_profile();
	}
	
	//mentorProfileForm.jsp에서 작성한 프로필 정보 등록
	@PutMapping("/edit-profile")
	public ResponseEntity<?> updateMentorProfile(@RequestBody MentorProfileDTO mentorProfileDTO){
		System.out.println(mentorProfileDTO);
		mtpService.update_mentor_profile(mentorProfileDTO);
	    return ResponseEntity.ok("Success");
	}
	
	//mentor_tag에 체크한 태그를 추가
	@PutMapping("/edit-mentor-tag")
	public ResponseEntity<?> insert_mentor_tag(@RequestBody List<MentorTagDTO> mentor_tag_list){
		mtpService.insert_mentor_tag(mentor_tag_list);
	    return ResponseEntity.ok("Success");
	}
	
	//멘토 이메일로 멘토 태그 정보 삭제
	@DeleteMapping("/delete-mentor-tag")
	public ResponseEntity<?> delete_mentor_tag(@RequestBody String mentor_email){
		mtpService.delete_mentor_tag(mentor_email);
		return ResponseEntity.ok("Success");
	}
	
	//멘토 회원이 일반회원으로 전환 할때 멘토 프로필 삭제
	@DeleteMapping("/delete-mentor-profile")
	public void delete_mentor_profile(@RequestBody Map<String, String> email) {
		String mentor_email = email.get("mentor_email");
		mtpService.delete_mentor_profile(mentor_email);
	}
	
	//멘토 이메일로 멘토 프로필 가져오기
	@PostMapping("/get-mentor-profile")
	public String select_by_email_mentor_profile(@RequestBody Map<String, String> mentor_email) throws JsonProcessingException {
		String mentor_profile = mtpService.select_by_email_mentor_profile(mentor_email);
		return mentor_profile;
	}
	
	@PostMapping("/profile/payment/mentoring-application")
	public ResponseEntity<String> checkMentoringApplication(@RequestBody Map<String, String> requestData) {
	    String holder_email = requestData.get("holder_email");
	    String priceString = requestData.get("price");
	    int price = Integer.parseInt(priceString);
	    System.out.println(price);
	    
	    boolean result = ps.checkMentoringApplication(holder_email, price);
	    System.out.println(result);
	    return ResponseEntity.ok(Boolean.toString(result));
	}
	
	@PostMapping("/mentoring/adpay")
	public ResponseEntity<List<MemberDto>> getInfoForPayment(@RequestParam String lol_account){
		List<MemberDto> md = ps.getInfoForPayment(lol_account);
		System.out.println(md);
		return ResponseEntity.ok(md);
	}
	
	@PostMapping("/myMentoring/tx.json")
	public void txHistory(@RequestBody TransactionHistoryDTO tx_history){
		System.out.println(tx_history);
	    ps.insert_tx_history(tx_history);
	}

	@PostMapping("/application-class/lowerPoint.json")
	public void lowerPoint(@RequestBody Map<String, String> requestData) {
		String holder_email = requestData.get("email");
		String priceStr = requestData.get("price");
		int price = Integer.parseInt(priceStr);
		
		ps.lowerPoint(holder_email, price);
	}
	
}
	
