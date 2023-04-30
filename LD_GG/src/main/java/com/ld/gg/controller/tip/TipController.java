package com.ld.gg.controller.tip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ld.gg.service.TipBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tip")
public class TipController {
	@Autowired
	private TipBoardService ts;
	
	
}
