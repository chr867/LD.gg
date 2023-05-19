package com.ld.gg.controller.chat;

import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
    @Autowired
    public ChatService chatService;

    /* 채팅 페이지로 이동 */
    @GetMapping("/list")
    public ModelAndView go_chat(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        return new ModelAndView("/chat/chatList").addObject("email", email);
    }

    /* 채팅방 입장 시 */
    @GetMapping("/enter_chatroom")
    public ModelAndView chatRoom(HttpServletRequest request, @RequestParam("chat_room_seq") int chatroomseq, @RequestParam("chat_category") int chat_category){
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        System.out.println(email);
        System.out.println(chatroomseq);

        return new ModelAndView("/chat/chattingRoom").addObject("email", email).addObject("chat_room_seq", chatroomseq).addObject("chat_category", chat_category);
    }

    /* 실시간 채팅 */
    @MessageMapping("/chatroom")
    @SendTo("/topic/public")
    public Message register(@Payload Message ms, SimpMessageHeaderAccessor sma){
        sma.getSessionAttributes().put("username", ms.getChat_user());
        return ms;
    }

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/chatroom/{chat_room_seq}")
    public void sendMessage(HttpServletRequest request, @DestinationVariable int chat_room_seq, @Payload Message message) {
        System.out.println("sendMessage 실행...");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        // chat List에 db insert 하고 오기
        ChatListDto chatListDto = null;

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

    @MessageMapping("/lol_chat.send")
    @SendTo("/topic/public")
    public Message sendMessage(@Payload Message ms){
        return ms;
    }

}
