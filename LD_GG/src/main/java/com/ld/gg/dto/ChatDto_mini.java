package com.ld.gg.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("chat_mini")
public class ChatDto_mini {
	private String mini_game_send_user;
	private String mini_game_chat_content;
	private Timestamp mini_game_chat_time;
}
