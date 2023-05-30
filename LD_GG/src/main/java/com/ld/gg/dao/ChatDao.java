package com.ld.gg.dao;

import com.ld.gg.controller.chat.Message;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.chat.ChatDto_mini;
import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;

import java.util.List;

public interface ChatDao {

	Boolean save_minigame_chat(ChatDto_mini cm);

	List<String> select_mentor(String email);

	boolean insert_chat_list(ChatroomDto croomdto);

	boolean insert_chat_room(ChatroomDto croomdto);

	List<ChatListDto> select_chat_content(int chatRoomSeq);

	List<ChatroomDto> select_chat_list(String email);

	int select_chat_room_seq(ChatroomDto croomdto);

	boolean insert_chat_content(ChatListDto chatListDto);

	List<String> select_menti(String email);


	int insert_chatroomSEQ(ChatroomDto chatroomDto);

	Integer select_chatroomSEQ_reverse(ChatroomDto chatroomDto);

	Integer select_chatroomSEQ(ChatroomDto chatroomDto);

	ChatroomDto select_user(int chatRoomSeq);

	List<MemberDto> get_mentor(String email);

	List<MemberDto> get_menti(String email);

	List<MemberDto> get_mateapp(String email);

	List<MemberDto> get_mate(String email);
}
