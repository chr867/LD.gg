package com.ld.gg.controller.mate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.MateDto;
import com.ld.gg.service.MateService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/mate")
public class MateRestController {
	@Autowired
	MateService ms;
	
	@GetMapping("/list.json")
	public String MateList() throws Exception{
		log.info("메이트레스트 컨트롤러 탔어용");
		List<MateDto> mList= ms.getMateList();
		
	    ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(mList);
		log.info(json);
		
		return json;
	}
/*	@GetMapping("/search.json")//상세페이지 제작후 만들기
	public String mateSearch(String keyword) {
		log.info("메이트레스트 서치 탔어용");
		
		}*/
		
		
		
	

}
