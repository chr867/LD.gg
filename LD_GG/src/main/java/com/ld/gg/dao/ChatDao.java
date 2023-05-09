package com.ld.gg.dao;

import com.ld.gg.dto.chat.ChatDto_mini;

import java.util.List;

public interface ChatDao {

	Boolean save_minigame_chat(ChatDto_mini cm);

	List<String> select_by_email_mentor_list(String email);
}
