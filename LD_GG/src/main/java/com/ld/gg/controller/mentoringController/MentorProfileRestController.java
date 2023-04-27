package com.ld.gg.controller.mentoringController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.dto.mentoringdto.MentorProfileDTO;
import com.ld.gg.service.mentoringService.MentorProfileService;

@RestController
@RequestMapping("/mentoring")
public class MentorProfileRestController {
	
	@Autowired
	private MentorProfileService mtpService;
	
	@GetMapping("/search-mentor")
	public List<MentorProfileDTO> select_all_mentor_profile(){
		List<MentorProfileDTO> mtpList = mtpService.select_all_mentor_profiles();
		System.out.println(mtpList);
		return null;
	}
}
