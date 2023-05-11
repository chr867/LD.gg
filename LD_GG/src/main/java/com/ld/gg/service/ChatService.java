package com.ld.gg.service;

import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;
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

	/*chat_room 테이블에 insert 하고 chat_room_seq 가져옴.*/
	public int getChatRoomSeq(ChatroomDto croomdto) {
		System.out.println("insert_chat_list : " + croomdto.getChat_send_user());

		boolean res = cd.insert_chat_room(croomdto);

		int chatroom_seq = 0;

		if(res == true){
			System.out.println("chatroom insert success...");
			chatroom_seq = croomdto.getChat_room_seq();
		} else {
			System.out.println("chatroom insert failed...");
		}

		return chatroom_seq;
	}

	public List<ChatListDto> getChatContent(int chatRoomSeq) {
		System.out.println("getChatContent 실행..");

		List<ChatListDto> chat_content_list = cd.select_chat_content(chatRoomSeq);

		if(chat_content_list == null) {
			System.out.println("채팅 내용 얻어오기 망함.");
		} else{
			log.info("{}", chat_content_list);
		}

		return chat_content_list;
	}

	public boolean insert_chat_list(ChatListDto chatListDto) {
		// chat_list 테이블에 insert
		boolean res = cd.insert_chat_content(chatListDto);

		if(res == false){
			System.out.println("chat_list 저장 성공");
		}

		return false;
	}

	public List<ChatroomDto> getChatRoomList(String email) {
		List<ChatroomDto> chatroomDtoList = cd.select_chat_list(email);

		return chatroomDtoList;
	}

	public int select_chat_room_seq(ChatroomDto croomdto) {
		System.out.println("select_chat_room_seq 실행...");
		log.info("chatroom : {}", croomdto);

		int chat_room_seq = cd.select_chat_room_seq(croomdto);

		return chat_room_seq;
	}
}
