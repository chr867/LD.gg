package com.ld.gg.service.mentoringService;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.ld.gg.dao.MemberDao;
import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dao.mentoringdao.MyMentoringDAO;
import com.ld.gg.dao.mentoringdao.TagListDAO;
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
import com.ld.gg.service.MemberService;
import com.ld.gg.dto.mentoringdto.EstimateDTO;

@Service
public class MentorProfileService {
	
	@Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }
	@Autowired
	private MentorProfileDAO mtpdao;
	@Autowired
	private TagListDAO tagdao;
	@Autowired
	private MentiDAO mentidao;
	@Autowired
	private MyMentoringDAO mymtdao;
	@Autowired
	private MemberDao mbdao;
	@Autowired
	private MemberService mbService;
	@Autowired
	private ObjectMapper objectMapper;
	
	//모든 챔피언 이름 가져오기
	public String select_all_champ() throws JsonProcessingException {
		List<Champ_default> champ_name_list = mentidao.select_all_champ();
		String champ_name_list_json = objectMapper.writeValueAsString(champ_name_list);
		return champ_name_list_json;
	}
	//챔피언 아이디로 챔피언 이름 가져오기
	public String select_by_id_champ(int id) throws JsonProcessingException {
		Champ_default champ_name = mentidao.select_by_id_champ(id);
		String champ_name_json = objectMapper.writeValueAsString(champ_name);
		return champ_name_json;
	}
	
	//리뷰어 이메일로 내가 쓴 리뷰 가져오기
	public String select_by_reviewer_email_mentor_review(Map<String,String> reviewer_email) throws JsonProcessingException {
		String email = reviewer_email.get("reviewer_email");
		List<MentorReviewDTO> mentor_review_list = mentidao.select_by_reviewer_email_mentor_review(email);
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String mentor_review_list_json = objectMapper.writeValueAsString(mentor_review_list);
		return mentor_review_list_json;
	}
	//멘토 이메일로 나에게 달린 리뷰 가져오기
	public String select_by_mentor_email_mentor_review(Map<String,String> reviewer_email) throws JsonProcessingException {
		String mentor_email = reviewer_email.get("mentor_email");
		List<MentorReviewDTO> mentor_review_list = mentidao.select_by_mentor_email_mentor_review(mentor_email);
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String mentor_review_list_json = objectMapper.writeValueAsString(mentor_review_list);
		return mentor_review_list_json;
	}
	//리뷰 생성
	@Transactional
	public void insert_mentor_review(MentorReviewDTO mentor_review_dto) {
		String mentor_lol_account = mentor_review_dto.getMentor_email();
		List<MemberDto> mbdto= mbdao.getMemberLolAccount(mentor_lol_account);
		String mentor_email = mbdto.get(0).getEmail();
		mentor_review_dto.setMentor_email(mentor_email);
		mentidao.insert_mentor_review(mentor_review_dto); //리뷰 인서트
		MentorProfileDTO mtpdto = mtpdao.select_by_email_mentor_profile(mentor_email);
		float grade = mentor_review_dto.getGrade(); //리뷰점수
		int reviews = mtpdto.getNum_of_reviews(); //멘토 프로필 리뷰수
		float total_grade = mtpdto.getTotal_grade(); //멘토 프로필 점수
		mtpdto.setNum_of_reviews(reviews+1);
		mtpdto.setTotal_grade(total_grade+grade);
		mtpdao.update_mentor_profile(mtpdto); //멘토 프로필에 리뷰수+1 평점 적용
	}
	
	//리뷰 삭제
	@Transactional
	public void delete_mentor_review(Map<String, Integer> map_review_num) {
		Integer review_num = map_review_num.get("review_num");
		MentorReviewDTO mtrdto = mentidao.select_by_review_num(review_num);
		String mentor_email = mtrdto.getMentor_email();
		MentorProfileDTO mtpdto = mtpdao.select_by_email_mentor_profile(mentor_email);
		float grade = mtrdto.getGrade(); //리뷰점수
		int reviews = mtpdto.getNum_of_reviews(); //멘토 프로필 리뷰수
		float total_grade = mtpdto.getTotal_grade(); //멘토 프로필 점수
		mtpdto.setNum_of_reviews(reviews-1);
		mtpdto.setTotal_grade(total_grade-grade);
		mtpdao.update_mentor_profile(mtpdto); //멘토 프로필에 리뷰수-1 평점 -적용
		mentidao.delete_mentor_review(review_num); //리뷰 삭제
	}
	
	//이메일로 내가 찜한 멘토 목록 가져오기
	public String select_by_email_like_mentor(Map<String, String> emailmap) throws JsonProcessingException{
		String email = emailmap.get("email");
		List<LikeMentorDTO> like_mentor_list = mymtdao.select_by_email_like_mentor(email);
		String like_mentor_list_json = objectMapper.writeValueAsString(like_mentor_list);
		return like_mentor_list_json;
	}
	
	//멘토 이메일로 찜당한 횟수 가져오기
	public Integer count_by_mentor_email_like_mentor(String like_mentor) {
		Integer count_likes = mymtdao.count_by_mentor_email_like_mentor(like_mentor);
		return count_likes;
	}
	
	//찜한 멘토 추가
	@Transactional
	public void insert_like_mentor(LikeMentorDTO like_mentor_dto) {
		mymtdao.insert_like_mentor(like_mentor_dto);
		String mentor_email = like_mentor_dto.getLike_mentor();
		MentorProfileDTO mtpdto= mtpdao.select_by_email_mentor_profile(mentor_email);
		int likes = mtpdto.getNum_of_likes();
		MentorProfileDTO like_mtp_dto = mtpdto.setNum_of_likes(likes+1); //찜한 횟수 추가
		update_mentor_profile(like_mtp_dto);
	}
	
	//찜한 멘토 삭제
	@Transactional
	public void delete_like_mentor(LikeMentorDTO like_mentor_dto) {
		mymtdao.delete_like_mentor(like_mentor_dto);
		String mentor_email = like_mentor_dto.getLike_mentor();
		MentorProfileDTO mtpdto= mtpdao.select_by_email_mentor_profile(mentor_email);
		int likes = mtpdto.getNum_of_likes();
		MentorProfileDTO like_mtp_dto = mtpdto.setNum_of_likes(likes-1); //찜한 횟수 감소
		update_mentor_profile(like_mtp_dto);
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
		List<MemberDto> mb = mbService.findLolAccount(estdto.getMenti_email());
		EstimateDTO newest = estdto.setMenti_email(mb.get(0).getEmail());
		mymtdao.insert_estimate(newest);
	}
	//견적서 삭제
	public void delete_estimate(Map<String , Integer> estid) {
		int estimate_id = estid.get("estimate_id");
		mymtdao.delete_estimate(estimate_id);
	}
	
	//내 이메일로 나의 멘토링 신청 내역 가져오기
	public String select_by_email_my_mentoring(@RequestBody Map<String,String> emailMap) throws JsonProcessingException{
		String email = (String)emailMap.get("email");
		List<MyMentoringDTO> my_mt_list= mymtdao.select_by_email_my_mentoring(email);
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String my_mt_list_json = objectMapper.writeValueAsString(my_mt_list);
		return my_mt_list_json;
	}
	//멘토 이메일로 나에게 수강신청한 멘티 내역 가져오기
	public String select_by_mentor_email_my_mentoring(@RequestBody Map<String,String> emailMap) throws JsonProcessingException{
		String mentor_email = (String)emailMap.get("email");
		List<MyMentoringDTO> my_mt_list= mymtdao.select_by_mentor_email_my_mentoring(mentor_email);
		objectMapper.registerModule(new JavaTimeModule()); //LocalDateTime 타입 변수 json으로 변환
		String my_mt_list_json = objectMapper.writeValueAsString(my_mt_list);
		return my_mt_list_json;
	}
	//멘토링 내역 추가
	public void insert_my_mentoring(MyMentoringDTO my_mt_dto) {
		mymtdao.insert_my_mentoring(my_mt_dto);
	}
	
	//멘토링 내역 수정
	@Transactional
	public void update_my_mentoring(MyMentoringDTO my_mt_dto) {
		List<MemberDto> mb = mbService.findLolAccount(my_mt_dto.getMenti_email()); //소환사명으로 회원정보 조회
		String email = mb.get(0).getEmail(); //회원 정보에서 이메일 추출
		MyMentoringDTO newest = my_mt_dto.setMenti_email(email); //추출한 이메일로 dto 다시 세팅
		mymtdao.update_my_mentoring(newest); //멘토링 내역 수정
		int state = my_mt_dto.getMenti_state(); //멘토링 내역에서 멘티 상태 추출
		if(state == 2) { //수업 완료를 누르면
			String mentor_email = my_mt_dto.getMentor_email();
			MentorProfileDTO mtpdto = mtpdao.select_by_email_mentor_profile(mentor_email);
			int lessons = mtpdto.getNum_of_lessons();
			MentorProfileDTO lessons_mtp_dto = mtpdto.setNum_of_lessons(lessons+1); //레슨 수 증가
			update_mentor_profile(lessons_mtp_dto); //멘토 프로필 수정
		}
	}
	//멘토링 내역 삭제
	public void delete_my_mentoring(MyMentoringDTO my_mt_dto) {
		mymtdao.delete_my_mentoring(my_mt_dto);
	}
	//멘티 소환사명 받아서 멘토링 내역 삭제
	public void reject_my_mentoring(MyMentoringDTO my_mt_dto) {
		String summoner_name = my_mt_dto.getMenti_email();
		List<MemberDto> mbdto = mbdao.getMemberLolAccount(summoner_name);
		String menti_email = mbdto.get(0).getEmail();
		my_mt_dto.setMenti_email(menti_email);
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
	// 클래스 아이디로 멘토 클래스 정보 가져오기
	public String select_by_id_mentor_class(int class_id) throws JsonProcessingException {
		MentorClassDTO mentor_class_dto = mtpdao.select_by_id_mentor_class(class_id);
		ObjectMapper objectMapper = new ObjectMapper();
		String mentor_class_json = objectMapper.writeValueAsString(mentor_class_dto);
		return mentor_class_json;
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
	
	//목표 태그 가져오기
	public String select_taget_tag() throws JsonProcessingException{
		List<TagListDTO> taget_tag = tagdao.select_by_tag_type("target");
		String taget_tag_list = objectMapper.writeValueAsString(taget_tag);
		return taget_tag_list;
	}
	//수업방식 태그 가져오기
	public String select_class_method_tag() throws JsonProcessingException{
		List<TagListDTO> class_method_tag = tagdao.select_by_tag_type("class_method");
		String class_method_tag_list = objectMapper.writeValueAsString(class_method_tag);
		return class_method_tag_list;
	}
	//스타일 태그 가져오기
	public String select_style_tag() throws JsonProcessingException{
		List<TagListDTO> style_tag = tagdao.select_by_tag_type("style");
		String style_tag_list = objectMapper.writeValueAsString(style_tag);
		return style_tag_list;
	}
	//스타일2 태그 가져오기
	public String select_style2_tag() throws JsonProcessingException{
		List<TagListDTO> style2_tag = tagdao.select_by_tag_type("style2");
		String style2_tag_list = objectMapper.writeValueAsString(style2_tag);
		return style2_tag_list;
	}
	//경력 태그 가져오기
	public String select_careers_tag() throws JsonProcessingException{
		List<TagListDTO> careers_tag = tagdao.select_by_tag_type("careers");
		String careers_tag_list = objectMapper.writeValueAsString(careers_tag);
		return careers_tag_list;
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
	public String select_by_email_mentor_profile(Map<String, String> mentor_email) throws JsonProcessingException {
		String email =mentor_email.get("mentor_email");
		MentorProfileDTO mtp = mtpdao.select_by_email_mentor_profile(email);
		String mentor_profile = objectMapper.writeValueAsString(mtp);
		return mentor_profile;
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
