package com.ld.gg.dto.chat;

public class ChatroomDto {
    private int chat_room_seq; // 채팅방 시퀀스
    private int chat_category; // 채팅방 종류 0 : mentor, 1 : mate
    private String chat_send_user; // 받는 사람
    private String chat_receive_user; // 보낸 사람
}
