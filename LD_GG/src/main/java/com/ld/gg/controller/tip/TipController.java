package com.ld.gg.controller.tip;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ld.gg.service.TipService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tip")
public class TipController {
	@Autowired
	private TipService ts;
	
	@GetMapping("/")
	public String goTipList(Model model) {
		return "/tip/list";
	}
	
	@GetMapping("/details")
	public String tipDetails(Model model) {
		return "/tip/details";
	}
	
	@GetMapping("/write")
	public String tipWrite(Model model) {
		return "/tip/write";
	}
}
