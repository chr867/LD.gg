package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.ChatDao;
import com.ld.gg.dto.chat.ChatDto_mini;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatService {
	@Autowired
	ChatDao cd;
	
	public void save_minigame_chat(ChatDto_mini cm) {
		Boolean result = cd.save_minigame_chat(cm);
		if(result) {
			System.out.println("채팅 저장 성공");
		}
	}
	
}
