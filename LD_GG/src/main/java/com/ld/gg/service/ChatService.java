package com.ld.gg.service;

import com.ld.gg.dao.mentoringdao.MentiDAO;
import com.ld.gg.dao.mentoringdao.MentorProfileDAO;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.ChatDao;
import com.ld.gg.dto.chat.ChatDto_mini;

import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<String> select_mentoring(String email) {
		System.out.println("chatService의 select_mentoring 호출" + email);

		List<String> mentoring_list = cd.select_mentor(email);

		if(mentoring_list.size() == 0){
			System.out.println("조회 결과 없음. select_menti...");
			mentoring_list = cd.select_menti(email);
		} else{
			System.out.println("조회 성공!");
		}

		log.info("mentor_list : {}", mentoring_list);

		return mentoring_list;
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

		return res;
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

    public List<String> select_menti(String email) {
		System.out.println("select_menti 실행...");

		List<String> mentoring_list = cd.select_menti(email);

		System.out.println("실행");
		log.info("mentor_list : {}", mentoring_list);

		return mentoring_list;
	}

	public int find_chatroomSEQ(ChatroomDto chatroomDto) {
		log.info("find_chatroomSEQ : {}", chatroomDto);

		// select chat_room_seq
		Integer chatroomSEQ = null;

		System.out.println("cd.select_chatroomSEQ(chatroomDto);");
		chatroomSEQ = cd.select_chatroomSEQ(chatroomDto);
		System.out.println("cd.select_chatroomSEQ(chatroomDto) : " + chatroomSEQ);

		if(chatroomSEQ == null){
			System.out.println("111 1find_chatroomSEQ : " + chatroomSEQ);
			chatroomSEQ = cd.select_chatroomSEQ_reverse(chatroomDto);
			System.out.println("fffff : " + chatroomSEQ);
			if(chatroomSEQ == null){
				System.out.println("2222find_chatroomSEQ : " + chatroomSEQ);
				chatroomSEQ = cd.insert_chatroomSEQ(chatroomDto);
			}
		}

		System.out.println("find_chatroomSEQ : " + chatroomSEQ);
		return chatroomSEQ;
	}

	public ChatroomDto select_user(int chatRoomSeq) {
		ChatroomDto chatroomDto = cd.select_user(chatRoomSeq);

		return chatroomDto;
	}

	/* mento, menti, mate 가져오기 */
    public Map<String, List<?>> get_mento_mate(String email) {
		Map<String, List<?>> map_mento_mate = new HashMap<>();

		/* mentoring */
		List<MemberDto> mentor_list = cd.get_mentor(email);
		List<MemberDto> menti_list = cd.get_menti(email);

		/* mate */
		List<MemberDto> mateapp_list = cd.get_mateapp(email);
		List<MemberDto> mate_list = cd.get_mate(email);

		map_mento_mate.put("mentor_list", mentor_list);
		map_mento_mate.put("menti_list", menti_list);

		map_mento_mate.put("mateapp_list", mateapp_list);
		map_mento_mate.put("mate_list", mate_list);

		return map_mento_mate;
    }
}
