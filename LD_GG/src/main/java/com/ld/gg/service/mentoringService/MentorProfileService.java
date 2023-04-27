package com.ld.gg.service.mentoringService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dto.mentoringdto.MentorProfileDTO;

@Service
public class MentorProfileService {
	
	@Autowired
	private MentorProfileDAO mtpdao;
	
	public List<MentorProfileDTO> select_all_mentor_profiles(){
		List<MentorProfileDTO> mtpdto =mtpdao.select_all_mentor_profiles();
		return mtpdto;
	}

	public MentorProfileDTO select_by_email_mentor_profile(String mentor_email) {
		MentorProfileDTO mtp = mtpdao.select_by_email_mentor_profile(mentor_email);
		return mtp;
	}
	
	
}
