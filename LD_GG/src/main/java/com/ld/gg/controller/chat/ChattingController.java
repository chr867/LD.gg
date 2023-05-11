package com.ld.gg.controller.chat;

import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.service.ChatService;
import com.sun.tools.jconsole.JConsoleContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@Slf4j
public class ChattingController {
    /* 실시간 통신 관련 설정 클래스 */
    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    @Autowired
    public ChatService chatService;
    @MessageMapping("/chat/chatroom/{chat_room_seq}")
    public void sendMessage(@DestinationVariable int chat_room_seq, @Payload Message message) {
        // 요청이 잘 들어왔는지 확인
        System.out.println("sendMessage 실행...");

        /* Message 값이 잘 들어왔는지 확인 */
        log.info("{}", chat_room_seq);
        log.info("{}", message.getChat_content());
        log.info("{}", message.getChat_user());
        log.info("{}", message.getChat_category());

        // chat List에 db insert 하고 오기
        ChatListDto chatListDto = new ChatListDto();

        chatListDto.setChat_room_seq(chat_room_seq);
        chatListDto.setChat_category(message.getChat_category());
        chatListDto.setChat_content(message.getChat_content());
        chatListDto.setChat_user(message.getChat_user());

        boolean res = chatService.insert_chat_list(chatListDto);

        if(res != false){
            System.out.println("DB 처리 실패! 잠시 후 다시 시도하여 주십시오.");
        }
        else{
            messagingTemplate.convertAndSend("/topic/" + chat_room_seq, message);
        }
    }
}
