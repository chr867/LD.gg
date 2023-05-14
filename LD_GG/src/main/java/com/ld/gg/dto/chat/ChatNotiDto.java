package com.ld.gg.dto.chat;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

@Data
@Accessors(chain=true)
@Alias("chatnoti")
public class ChatNotiDto {
    private int notice_id;
    private int chat_seq;
    private int chat_room_seq;
    private int chat_category;
}
