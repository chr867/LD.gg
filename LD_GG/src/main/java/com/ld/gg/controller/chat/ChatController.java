package com.ld.gg.controller.chat;

import com.ld.gg.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
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

    /* chatList.jsp로 이동 */
    @GetMapping("/chat-list")
    public ModelAndView go_chatlist(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        System.out.println(email);

        return new ModelAndView("/chat/chatList").addObject("email", email);
    }


    @MessageMapping("/lol_chat.register")
    @SendTo("/topic/public")
    public Message register(@Payload Message ms, SimpMessageHeaderAccessor sma){
        sma.getSessionAttributes().put("username", ms.getSendUser());
        return ms;
    }

    @MessageMapping("/lol_chat.send")
    @SendTo("/topic/public")
    public Message sendMessage(@Payload Message ms){
        return ms;
    }

    @GetMapping("/chatroom/{email}")
    public String home(Model model) {
        return "chatRoom";
    }

    /* 채팅방 입장 시 */
    @GetMapping("/enter_chatroom/{chat_room_seq}")
    public ModelAndView chatRoom(HttpServletRequest request, @RequestParam("chat_room_seq") int chatroomseq){
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        System.out.println(email);
        System.out.println(chatroomseq);

        return new ModelAndView("/chat/chattingRoom").addObject("email", email).addObject("chat_room_seq", chatroomseq);
    }
}
