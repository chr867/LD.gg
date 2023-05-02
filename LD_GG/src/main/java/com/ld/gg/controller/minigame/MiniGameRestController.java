package com.ld.gg.controller.minigame;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.gg.dto.minigame.MiniGameDataDto;
import com.ld.gg.dto.minigame.MiniGameTimeDto;
import com.ld.gg.service.MiniGameService;

@RestController
@RequestMapping("/minigame")
public class MiniGameRestController {
	@Autowired
	MiniGameService ms;
	
	@RequestMapping("/data.json")
	public String data_minigame() throws Exception{
		MiniGameDataDto md = ms.data_minigame();
		md.setMinigame_result(-1);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(md);
		
		return json;
	}
	
	@RequestMapping("/timeline.json")
	public String timeline_minigame(@RequestParam(defaultValue = "5")Integer time) throws Exception{
		MiniGameTimeDto md = ms.timeline_minigame(time);
		md.setMinigame_result(-1);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		json = mapper.writeValueAsString(md);

		return json;
	}
	
	@RequestMapping(value="/submit.json", produces="application/json;charset=UTF-8")
	public String submit_minigame(Integer predict) {
		String tmp = null;
		Integer result = ms.submit_minigame();
		System.out.println("result = "+result);
		predict = 1;
		
		if(result == predict) {
			ms.point_update(5);
			tmp = "예측 성공";
		}else {
			ms.point_update(-5);
			tmp = "예측 실패";
		}

		return tmp;
	}
	
}
