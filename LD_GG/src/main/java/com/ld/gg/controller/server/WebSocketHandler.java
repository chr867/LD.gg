package com.ld.gg.controller.server;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ld.gg.dto.ChatDto_mini;
import com.ld.gg.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler{
	@Autowired
	ChatService cs;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("session = {}", session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("message = {}", message);
		log.info("session = {}", session);

		ChatDto_mini cm = new ChatDto_mini();
		cm.setMini_game_send_user(session.getId());
		cm.setMini_game_chat_content(message.getPayload());
		cm.setMini_game_chat_time(Timestamp.valueOf(LocalDateTime.now(ZoneId.of("Asia/Seoul"))));

		cs.save_minigame_chat(cm);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	}
}
