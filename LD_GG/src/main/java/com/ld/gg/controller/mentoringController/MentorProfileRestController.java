package com.ld.gg.controller.mentoringController;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorTagDTO;
import com.ld.gg.service.MemberService;
import com.ld.gg.service.mentoringService.MentorProfileService;

@RestController
@RequestMapping(value = "/mentor", produces = "text/html; charset=UTF-8")
public class MentorProfileRestController {
	
	@Autowired
	private MentorProfileService mtpService;
	@Autowired
	private MemberDao mbdao;
	
	//이메일로 멘토 클래스 가져오기
	@GetMapping("select-mentor-class")
	public String select_by_email_mentor_class(@RequestBody String email) throws JsonProcessingException{
		List<MentorClassDTO> class_list = mtpService.select_by_email_mentor_class(email);
		ObjectMapper objectMapper = new ObjectMapper();
		String class_List_json = objectMapper.writeValueAsString(class_list);
		return class_List_json;
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
		    String mentor_email = mtp.getMentor_email(); // mentor_email 추출
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
	
	//회원정보에 회원타입이 멘토인 사람들 멘토프로필에 인서트
	@PostMapping("/renewal-mentor-list")
	public void renewal_mentor_profile(){
		mtpService.renewal_mentor_profile();
	}
	
	//mentorProfileForm.jsp에서 작성한 프로필 정보 등록
	@PutMapping("/edit-profile")
	public ResponseEntity<?> updateMentorProfile(@RequestBody MentorProfileDTO mentorProfileDTO){
		mtpService.update_mentor_profile(mentorProfileDTO);
	    return ResponseEntity.ok("Success");
	}
	
	//mentor_tag에 체크한 태그를 추가
	@PutMapping("/edit-mentor-tag")
	public ResponseEntity<?> insert_mentor_tag(@RequestBody List<MentorTagDTO> mentor_tag_list){
		System.out.println(mentor_tag_list);
		mtpService.insert_mentor_tag(mentor_tag_list);
	    return ResponseEntity.ok("Success");
	}
	
	//멘토 이메일로 멘토태그 정보 삭제
	@DeleteMapping("/delete-mentor-tag")
	public ResponseEntity<?> delete_mentor_tag(@RequestBody String mentor_email){
		System.out.println(mentor_email);
		mtpService.delete_mentor_tag(mentor_email);
		return ResponseEntity.ok("Success");
	}
	
	//멘토 회원이 일반회원으로 전환 할때 멘토 프로필 삭제
	@DeleteMapping("/delete-mentor-profile")
	public void delete_mentor_profile(@RequestBody Map<String, String> email) {
		String mentor_email = email.get("mentor_email");
		mtpService.delete_mentor_profile(mentor_email);
	}
}
	
