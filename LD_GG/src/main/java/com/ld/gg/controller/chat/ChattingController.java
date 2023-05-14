package com.ld.gg.controller.chat;

import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;
import com.ld.gg.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@Controller
@Slf4j
public class ChattingController {
    /* 실시간 통신 관련 설정 클래스 */
    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    @Autowired
    public ChatService chatService;
    @MessageMapping("/chat/chatroom/{chat_room_seq}")
    public void sendMessage(@DestinationVariable int chat_room_seq, @Payload Message message) throws ParseException {
        // 요청이 잘 들어왔는지 확인
        System.out.println("sendMessage 실행...");


        ChatListDto chatListDto = new ChatListDto();
        // SimpleDateFormat을 사용하여 문자열을 Timestamp로 변환
        String dateString = message.getChat_time();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try {
            java.util.Date parsedDate = dateFormat.parse(dateString);
            Timestamp timestamp = new Timestamp(parsedDate.getTime());
            chatListDto.setChat_time(timestamp);
            System.out.println(timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        /* Message 값이 잘 들어왔는지 확인 */
        log.info("{}", chat_room_seq);
        log.info("{}", message.getChat_content());
        log.info("{}", message.getChat_user());
        log.info("{}", message.getChat_category());
        log.info("{}", message.getChat_time());

        // chat List에 db insert 하고 오기

        chatListDto.setChat_room_seq(chat_room_seq);
        chatListDto.setChat_category(message.getChat_category());
        chatListDto.setChat_content(message.getChat_content());
        chatListDto.setChat_user(message.getChat_user());

        ChatroomDto chatroomDto = new ChatroomDto();

        boolean res = chatService.insert_chat_list(chatListDto);
        chatroomDto = chatService.select_user(chat_room_seq);

        if(res == false){
            System.out.println("DB 처리 실패! 잠시 후 다시 시도하여 주십시오.");
        }
        else{
            messagingTemplate.convertAndSend("/topic/" + chatroomDto.getChat_send_user(), message);
            messagingTemplate.convertAndSend("/topic/" + chatroomDto.getChat_receive_user(), message);
            messagingTemplate.convertAndSend("/topic/" + chat_room_seq, message);
        }
    }
}
