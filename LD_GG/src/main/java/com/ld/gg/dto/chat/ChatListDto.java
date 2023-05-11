package com.ld.gg.dto.chat;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@Accessors(chain=true)
@Alias("chatlist")
public class ChatListDto {
    private int chat_seq;
    private int chat_room_seq;
    private int chat_category;
    private String chat_content;
    private Timestamp chat_time;
    private String chat_user;
}
