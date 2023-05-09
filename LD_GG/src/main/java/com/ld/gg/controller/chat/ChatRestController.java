package com.ld.gg.controller.chat;

import com.ld.gg.service.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
}
