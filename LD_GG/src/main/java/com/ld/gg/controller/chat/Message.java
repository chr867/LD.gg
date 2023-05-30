package com.ld.gg.controller.chat;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Getter
@Setter
@Alias("message")
public class Message {
    private int chat_category; // chat_category
    private String chat_content;
    private String chat_user; // 발신 유저
    private String chat_time;
}
