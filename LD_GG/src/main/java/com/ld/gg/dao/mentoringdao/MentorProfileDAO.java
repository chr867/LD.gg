package com.ld.gg.dao.mentoringdao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ld.gg.dto.mentoringdto.MentorProfileDTO;

@Mapper
public interface MentorProfileDAO {
	List<MentorProfileDTO> select_all_mentor_profiles();
	MentorProfileDTO select_by_email_mentor_profile(String mentor_email);
	void insert_mentor_profile(MentorProfileDTO mentor_profile);
	void update_mentor_profile(MentorProfileDTO mentor_profile);
	void delete_mentor_profile(String mentor_email);
}
