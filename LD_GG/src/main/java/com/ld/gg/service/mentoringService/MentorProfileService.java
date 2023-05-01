package com.ld.gg.service.mentoringService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dao.mentoringdao.TagListDAO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorTagDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;

@Service
public class MentorProfileService {
	
	@Autowired
	private MentorProfileDAO mtpdao;
	@Autowired
	private TagListDAO tagdao;
	
	//이메일로 멘토 태그 가져오기
	public List<MentorTagDTO> select_by_email_mentor_tag(String mentor_email){
		List<MentorTagDTO> mentor_tag_dto = mtpdao.select_by_email_mentor_tag(mentor_email);
		return mentor_tag_dto;
	}
	
	//멘토 태그 등록
	public void insert_mentor_tag(String mentor_email, int[] tag_id_list) {
		
	}
	
	//모든 태그 리스트 가져오기
	public List<TagListDTO> select_all_tag(){
		List<TagListDTO> tagdto = tagdao.select_all_tag();
		return tagdto;
	}
	//태그 타입으로 태그 리스트 가져오기
	public List<TagListDTO> select_by_tag_type(String tag_type){
		List<TagListDTO> tagdto = tagdao.select_by_tag_type(tag_type);
		return tagdto;
	}
	//태그 아이디로 태그 가져오기
	public TagListDTO select_by_id_tag(int tag_id){
		TagListDTO tagdto = tagdao.select_by_id_tag(tag_id);
		return tagdto;
	}
	
	//모든 멘토 프로필 리스트 가져오기
	public List<MentorProfileDTO> select_all_mentor_profiles(){
		List<MentorProfileDTO> mtpdto =mtpdao.select_all_mentor_profiles();
		return mtpdto;
	}
	
	//이메일로 멘토 프로필 가져오기
	public MentorProfileDTO select_by_email_mentor_profile(String mentor_email) {
		MentorProfileDTO mtp = mtpdao.select_by_email_mentor_profile(mentor_email);
		return mtp;
	}
	
	//멤버 테이블에서 유저타입이 2인 모든 회원 멘토프로필 테이블에 인서트
	public void renewal_mentor_profile() {
		mtpdao.renewal_mentor_profile();
	}
	
	//이메일을 받아서 멘토프로필 테이블에 인서트
	public void insert_mentor_profile(String mentor_email) {
		mtpdao.insert_mentor_profile(mentor_email);
	}
	
	//멘토회원 프로필 수정 or 작성
	public void update_mentor_profile(MentorProfileDTO mentor_profile) {
		mtpdao.update_mentor_profile(mentor_profile);
	}

	//이메일을 받아서 멘토 프로필 삭제
	public void delete_mentor_profile(String mentor_email) {
		mtpdao.delete_mentor_profile(mentor_email);
	}
}
