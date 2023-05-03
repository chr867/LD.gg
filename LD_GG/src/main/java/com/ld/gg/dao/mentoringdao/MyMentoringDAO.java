package com.ld.gg.dao.mentoringdao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ld.gg.dto.mentoringdto.LikeMentorDTO;
import com.ld.gg.dto.mentoringdto.MyMentoringDTO;
import com.ld.gg.dto.mentoringdto.estimateDTO;

@Mapper
public interface MyMentoringDAO {
	estimateDTO select_by_id_estimate(int estimate_id);
	List<estimateDTO> select_by_mentor_email_estimate(String mentor_email);
	List<estimateDTO> select_by_menti_email_estimate(String menti_email);
	void insert_estimate(estimateDTO estdto);
	void delete_estimate(int estimate_id);
	
	
	List<MyMentoringDTO> select_by_email_my_mentoring(String email);
	List<MyMentoringDTO> select_by_mentor_email_my_mentoring(String mentor_email);
	void insert_my_mentoring(MyMentoringDTO my_mt_dto);
	void update_my_mentoring(MyMentoringDTO my_mt_dto);
	void delete_my_mentoring(MyMentoringDTO my_mt_dto);
	
	//이메일로 내가 찜한 멘토 목록 가져오기
	List<LikeMentorDTO> select_by_email_like_mentor(String email);
	//멘토 이메일로 찜당한 횟수 가져오기
	Integer count_by_mentor_email_like_mentor(String like_mentor);
	//찜한 멘토 추가
	void insert_like_mentor(LikeMentorDTO like_mentor_dto);
	//찜한 멘토 삭제
	void delete_like_mentor(LikeMentorDTO like_mentor_dto);
}
