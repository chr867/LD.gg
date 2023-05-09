package com.ld.gg.controller.chat;

import com.ld.gg.dto.chat.ChatListDto;
import com.ld.gg.dto.chat.ChatroomDto;
import com.ld.gg.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@RequestMapping("/chat")
@RestController
public class ChatRestController {
    @Autowired
    ChatService chatService;

   /* 나의 멘토 가져오기 */
    @PostMapping("/get_mentor_list")
    public List<String> getMentorList(String email) {
        System.out.println("get_mentor_list" + email);

        List<String> mentor_list = chatService.select_mentor(email);

        //List mentor_list = chatService.select_mentor(email);

        if(mentor_list == null){
            System.out.println("조회 결과 없음.");
        }
        else{
            System.out.println("조회 성공!");
            log.info("{}", mentor_list);
        }

        return mentor_list;
    }

    /* chat_room db에 채팅 정보 insert */
    @PostMapping("/go_chatroom")
    public int go_chatroom(ChatroomDto croomdto){
        System.out.println("chat_send_user : " + croomdto.getChat_send_user());
        System.out.println("chat_receive_user : " + croomdto.getChat_receive_user());

        int chat_room_seq = chatService.getChatRoomSeq(croomdto);

        if(chat_room_seq == 0) {
            System.out.println("망함.");
        }

        return chat_room_seq;
    }

    /* chatroom content load */
    @PostMapping("/get_chatting_data")
    public List get_chat_content(int chat_room_seq){
        System.out.println("chat_send_user : " + chat_room_seq);

        List<ChatListDto> chat_content_list= chatService.getChatContent(chat_room_seq);

        if(chat_content_list == null) {
            System.out.println("채팅 내용 얻어오기 망함.");
        }

        return chat_content_list;
    }
}
