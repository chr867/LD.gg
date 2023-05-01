package com.ld.gg.controller.tip;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.TipDto;
import com.ld.gg.service.TipService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/tip")
public class TipRestController {
	@Autowired
	private TipService ts;
	
	@GetMapping("/list.json")
	public String tipList() throws Exception {
        
        List<TipDto> tipList = ts.getTipList();
        
        ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(tipList);
		
		return json;
	}
	
	@GetMapping("/search.json")
	public String tipSearch(String keyword) throws Exception {
		log.info("공략 게시판 검색 진입");
        log.info(keyword);
        List<TipDto> searchList = ts.getSearchList(keyword);
        
        ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(searchList);
		
		return json;
	}
}
