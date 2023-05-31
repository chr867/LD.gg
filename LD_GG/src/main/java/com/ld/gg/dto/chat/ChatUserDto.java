package com.ld.gg.dto.chat;

import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

@Data
@Accessors(chain=true)
@Alias("chatuser")
public class ChatUserDto {
    private String email;
    private String lol_account;
    private String profile_icon_id;
}
