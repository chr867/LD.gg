package com.ld.gg.service;

import com.ld.gg.dao.mentoringdao.MentiDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.ChatDao;
import com.ld.gg.dto.chat.ChatDto_mini;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

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

	/* mentor email 가져오기 */
	public List<String> select_mentor(String email) {
		System.out.println("chatService의 select_mentor 호출" + email);

		List<String> mentor_list = cd.select_by_email_mentor_list(email);

		System.out.println("실행");
		log.info("mentor_list : {}", mentor_list);

		return mentor_list;
	}
}
