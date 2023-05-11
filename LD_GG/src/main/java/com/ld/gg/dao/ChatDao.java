package com.ld.gg.dao;

import com.ld.gg.dto.chat.ChatDto_mini;
import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;

import java.util.List;

public interface ChatDao {

	Boolean save_minigame_chat(ChatDto_mini cm);

	List<String> select_by_email_mentor_list(String email);

	boolean insert_chat_list(ChatroomDto croomdto);

	boolean insert_chat_room(ChatroomDto croomdto);

	List<ChatListDto> select_chat_content(int chatRoomSeq);

	List<ChatroomDto> select_chat_list(String email);

	int select_chat_room_seq(ChatroomDto croomdto);

	boolean insert_chat_content(ChatListDto chatListDto);
}
