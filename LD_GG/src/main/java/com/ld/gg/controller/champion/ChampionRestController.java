package com.ld.gg.controller.champion;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.service.Champion_Service;

@RestController
public class ChampionRestController {
	@Autowired
	Champion_Service cs;
}
