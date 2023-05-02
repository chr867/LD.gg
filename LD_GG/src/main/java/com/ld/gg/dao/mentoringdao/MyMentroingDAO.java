package com.ld.gg.dao.mentoringdao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ld.gg.dto.mentoringdto.MyMentoringDTO;
import com.ld.gg.dto.mentoringdto.estimateDTO;

@Mapper
public interface MyMentroingDAO {
	estimateDTO select_by_id_estimate(int estimate_id);
	List<estimateDTO> select_by_mentor_email_estimate(String mentor_email);
	List<estimateDTO> select_by_menti_email_estimate(String menti_email);
	void insert_estimate(estimateDTO estdto);
	void delete_estimate(int estimate_id);
	
	
	List<MyMentoringDTO> select_by_email_my_mentoring(String email);
	void insert_my_mentoring(MyMentoringDTO my_mt_dto);
	void update_my_mentoring(MyMentoringDTO my_mt_dto);
	void delete_my_mentoring(MyMentoringDTO my_mt_dto);
	
}