package com.ld.gg.controller.question;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/question")
public class QuestionController {
    /* 채팅방 목록으로 이동 */
    @GetMapping("/question")
    public ModelAndView go_chatlist(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        System.out.println(email);

        return new ModelAndView("/question/question").addObject("email", email);
    }
}
