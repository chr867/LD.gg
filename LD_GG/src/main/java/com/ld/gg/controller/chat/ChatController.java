package com.ld.gg.controller.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chat")
public class ChatController {
    @MessageMapping("/chat.register")
    @SendTo("/topic/public")
    public Message register(@Payload Message ms, SimpMessageHeaderAccessor sma){
        sma.getSessionAttributes().put("username", ms.getSendUser());
        return ms;
    }

    @MessageMapping("/chat.send")
    @SendTo("/topic/public")
    public Message sendMessage(@Payload Message ms){
        return ms;
    }

    @GetMapping("/chatroom")
    public String home(Model model) {
        return "/chat/chatroom";
    }
}
