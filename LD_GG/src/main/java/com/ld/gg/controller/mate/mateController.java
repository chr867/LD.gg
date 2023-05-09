package com.ld.gg.controller.mate;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mysql.cj.log.Log;

import lombok.extern.slf4j.Slf4j;
//mate dao mate_id,email,mate_content,mate_date,mate_title
@Slf4j
@Controller
@RequestMapping("/mate")
public class mateController {
	@GetMapping("/")
	public String goMateList() throws Exception{
		log.info("메이트 게시판 이동.");
		return "/mate/list";//구현해야됨
	}

	
}
