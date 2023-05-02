package com.ld.gg.service.mentoringService;

import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dao.mentoringdao.TagListDAO;
import com.ld.gg.dto.mentoringdto.CustomMentorDTO;
import com.ld.gg.dto.mentoringdto.MentiTagDTO;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorTagDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;

@Service
public class MentorProfileService {
	
	@Autowired
	private MentorProfileDAO mtpdao;
	@Autowired
	private TagListDAO tagdao;
	@Autowired
	private MentiDAO mentidao;
	
	//멘티 이메일로 맞춤멘토 추천
	public List<MentorProfileDTO> recom_mentor(String menti_email){
		List<MentorProfileDTO> recom_mentor_list = mentidao.recom_mentor(menti_email);
		return recom_mentor_list;
	}
	
	//이메일로 멘티 태그 가져오기
	public List<MentiTagDTO> select_by_email_menti_tag(String menti_email){
		List<MentiTagDTO> menti_tag_list = mentidao.select_by_email_menti_tag(menti_email);
		return menti_tag_list;
	}
	//멘티 태그 객체로 인서트
	public void insert_menti_tag(List<MentiTagDTO> menti_tag_list) {
		Iterator<MentiTagDTO> iterator = menti_tag_list.iterator();
		while (iterator.hasNext()) {
			MentiTagDTO menti_tag_dto = iterator.next();
			System.out.println(menti_tag_dto);
			mentidao.insert_menti_tag(menti_tag_dto);
		}
	}
	//멘트 이메일로 멘티 태그 삭제
	public void delete_menti_tag(String menti_email) {
		mentidao.delete_menti_tag(menti_email);
		
	}
	
	//모든 맞춤멘토 목록 가져오기
	public List<CustomMentorDTO> select_all_custom_mentor(){
		List<CustomMentorDTO> custom_mentor_dto_list= mentidao.select_all_custom_mentor();
		return custom_mentor_dto_list;
	}
	//이메일로 맞춤멘토 데이터 가져오기
	public CustomMentorDTO select_by_email_custom_mentor(String menti_email) {
		CustomMentorDTO custom_mentor_dto = mentidao.select_by_email_custom_mentor(menti_email);
		return custom_mentor_dto;
	}
	//이메일, 소환사명으로 맞춤멘토에 빈 데이터 넣기
	public void insert_custom_mentor(CustomMentorDTO custom_mentor) {
	    mentidao.insert_custom_mentor(custom_mentor);
	}
	//맞춤멘토 객체 받아서 업데이트
	public void update_custom_mentor(CustomMentorDTO custom_mentor) {
		mentidao.update_custom_mentor(custom_mentor);
	}
	//이메일로 맞춤멘토 삭제
	public void delete_custom_mentor(String menti_email) {
		mentidao.delete_custom_mentor(menti_email);
	}
	
	//이메일로 멘토 수업 목록 가져오기
	public List<MentorClassDTO> select_by_email_mentor_class(String mentor_email){
		List<MentorClassDTO> mentor_class_dto = mtpdao.select_by_email_mentor_class(mentor_email);
		return mentor_class_dto;
	}
	//멘토 클래스 인서트
	public void insert_mentor_class(MentorClassDTO mentor_class_dto) {
		mtpdao.insert_mentor_class(mentor_class_dto);
	}
	//멘토 클래스 업데이트
	public void update_mentor_class(MentorClassDTO mentor_class_dto) {
		mtpdao.update_mentor_class(mentor_class_dto);
	}
	//아이디로 멘토 클래스 삭제
	public void delete_mentor_class(int class_id) {
		mtpdao.delete_mentor_class(class_id);
	}
	
	//이메일로 멘토 태그 가져오기
	public List<MentorTagDTO> select_by_email_mentor_tag(String mentor_email){
		List<MentorTagDTO> mentor_tag_dto = mtpdao.select_by_email_mentor_tag(mentor_email);
		return mentor_tag_dto;
	}
	
	//멘토 태그 등록
	public void insert_mentor_tag(List<MentorTagDTO> mentor_tag_list) {
		Iterator<MentorTagDTO> iterator = mentor_tag_list.iterator();
		while (iterator.hasNext()) {
			MentorTagDTO mentor_tag_dto = iterator.next();
			mtpdao.insert_mentor_tag(mentor_tag_dto);
		}	
	}
	//멘토 태그 삭제
	public void delete_mentor_tag(String mentor_email) {
		mtpdao.delete_mentor_tag(mentor_email);
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
