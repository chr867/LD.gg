package com.ld.gg.dao.mentoringdao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.ld.gg.dto.mentoringdto.CustomMentorDTO;
import com.ld.gg.dto.mentoringdto.MentiTagDTO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.dto.mentoringdto.MentorReviewDTO;

@Mapper
public interface MentiDAO {
	//맞춤 멘토
	List<MentorProfileDTO> recom_mentor(String menti_email);
	List<CustomMentorDTO> select_all_custom_mentor();
	CustomMentorDTO select_by_email_custom_mentor(String menti_email);
	void insert_custom_mentor(CustomMentorDTO custom_mentor);
	void update_custom_mentor(CustomMentorDTO custom_mentor);
	void delete_custom_mentor(String menti_email);
	
	//나와 잘맞는 멘티
	List<CustomMentorDTO> recom_menti(String mentor_email);
	
	//멘티 태그
	List<MentiTagDTO> select_by_email_menti_tag(String menti_email);
	void insert_menti_tag(MentiTagDTO menti_tag_dto);
	void delete_menti_tag(String menti_email);
	
	//리뷰 기능
	MentorReviewDTO select_by_review_num(int review_num);
	List<MentorReviewDTO> select_by_reviewer_email_mentor_review(String reviewer_email);
	List<MentorReviewDTO> select_by_mentor_email_mentor_review(String mentor_email);
	void insert_mentor_review(MentorReviewDTO mentor_review_dto);
	void delete_mentor_review(int review_num);
}
