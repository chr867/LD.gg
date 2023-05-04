package com.ld.gg.service.mentoringService;

import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dao.mentoringdao.MyMentoringDAO;
import com.ld.gg.dao.mentoringdao.TagListDAO;
import com.ld.gg.dto.mentoringdto.CustomMentorDTO;
import com.ld.gg.dto.mentoringdto.LikeMentorDTO;
import com.ld.gg.dto.mentoringdto.MentiTagDTO;
import com.ld.gg.dto.mentoringdto.MentorClassDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorReviewDTO;
import com.ld.gg.dto.mentoringdto.MentorTagDTO;
import com.ld.gg.dto.mentoringdto.MyMentoringDTO;
import com.ld.gg.dto.mentoringdto.TagListDTO;
import com.ld.gg.dto.mentoringdto.EstimateDTO;

@Service
public class MentorProfileService {
	
	@Autowired
	private MentorProfileDAO mtpdao;
	@Autowired
	private TagListDAO tagdao;
	@Autowired
	private MentiDAO mentidao;
	@Autowired
	private MyMentoringDAO mymtdao;
	
	//리뷰어 이메일로 내가 쓴 리뷰 가져오기
	public String select_by_reviewer_email_mentor_review(String reviewer_email) throws JsonProcessingException {
		List<MentorReviewDTO> mentor_review_list = mentidao.select_by_reviewer_email_mentor_review(reviewer_email);
		ObjectMapper objectMapper = new ObjectMapper();
		String mentor_review_list_json = objectMapper.writeValueAsString(mentor_review_list);
		return mentor_review_list_json;
	}
	//멘토 이메일로 나에게 달린 리뷰 가져오기
	public String select_by_mentor_email_mentor_review(String mentor_email) throws JsonProcessingException {
		List<MentorReviewDTO> mentor_review_list = mentidao.select_by_mentor_email_mentor_review(mentor_email);
		ObjectMapper objectMapper = new ObjectMapper();
		String mentor_review_list_json = objectMapper.writeValueAsString(mentor_review_list);
		return mentor_review_list_json;
	}
	//리뷰 생성
	public void insert_mentor_review(MentorReviewDTO mentor_review_dto) {
		mentidao.insert_mentor_review(mentor_review_dto);
	}
	//리뷰 삭제
	public void delete_mentor_review(int review_num) {
		mentidao.delete_mentor_review(review_num);
	}
	
	//이메일로 내가 찜한 멘토 목록 가져오기
	public List<LikeMentorDTO> select_by_email_like_mentor(String email){
		List<LikeMentorDTO> like_mentor_list = mymtdao.select_by_email_like_mentor(email);
		return like_mentor_list;
	}
	//멘토 이메일로 찜당한 횟수 가져오기
	public Integer count_by_mentor_email_like_mentor(String like_mentor) {
		Integer count_likes = mymtdao.count_by_mentor_email_like_mentor(like_mentor);
		return count_likes;
	}
	//찜한 멘토 추가
	public void insert_like_mentor(LikeMentorDTO like_mentor_dto) {
		mymtdao.insert_like_mentor(like_mentor_dto);
	}
	//찜한 멘토 삭제
	public void delete_like_mentor(LikeMentorDTO like_mentor_dto) {
		mymtdao.delete_like_mentor(like_mentor_dto);
	}
	
	//멘토 이메일로 견적서 가져오기
	public List<EstimateDTO> select_by_mentor_email_estimate(String mentor_email){
		List<EstimateDTO> est_list = mymtdao.select_by_mentor_email_estimate(mentor_email);
		return est_list;
	}
	//멘티 이메일로 견적서 가져오기
	public List<EstimateDTO> select_by_menti_email_estimate(String menti_email){
		List<EstimateDTO> est_list = mymtdao.select_by_menti_email_estimate(menti_email);
		return est_list;
	}
	//견적서 추가
	public void insert_estimate(EstimateDTO estdto) {
		mymtdao.insert_estimate(estdto);
	}
	//견적서 삭제
	public void delete_estimate(int estimate_id) {
		mymtdao.delete_estimate(estimate_id);
	}
	
	//이메일로 멘토링 내역 가져오기
	public List<MyMentoringDTO> select_by_email_my_mentoring(String email){
		List<MyMentoringDTO> mymtdto = mymtdao.select_by_email_my_mentoring(email);
		return mymtdto;
	}
	//멘토 이메일로 멘토링 내역 가져오기
	public List<MyMentoringDTO> select_by_mentor_email_my_mentoring(String mentor_email){
		List<MyMentoringDTO> mymtdto = mymtdao.select_by_mentor_email_my_mentoring(mentor_email);
		return mymtdto;
	}
	//멘토링 내역 추가
	public void insert_my_mentoring(MyMentoringDTO my_mt_dto) {
		mymtdao.insert_my_mentoring(my_mt_dto);
	}
	//멘토링 내역 수정
	public void update_my_mentoring(MyMentoringDTO my_mt_dto) {
		mymtdao.update_my_mentoring(my_mt_dto);
	}
	//멘토링 내역 삭제
	public void delete_my_mentoring(MyMentoringDTO my_mt_dto) {
		mymtdao.delete_my_mentoring(my_mt_dto);
	}
	
	//멘토 이메일로 나와 잘 맞는 멘티 추천
	public List<CustomMentorDTO> recom_menti(String mentor_email) {
		List<CustomMentorDTO> recom_menti_list = mentidao.recom_menti(mentor_email);
		return recom_menti_list;
	}
	
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
