package com.ld.gg.controller.tip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.service.TipBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/tip")
public class TipRestController {
	@Autowired
	private TipBoardService ts;
	
	
}
