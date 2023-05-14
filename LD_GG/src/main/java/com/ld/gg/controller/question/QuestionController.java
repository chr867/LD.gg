package com.ld.gg.controller.question;

import com.ld.gg.dto.question.QuestionDto;
import com.ld.gg.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    QuestionService questionService;

    /* 채팅방 목록으로 이동 */
    @GetMapping("/question")
    public ModelAndView go_question_list(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        return new ModelAndView("question/questionList").addObject("email", email);
    }

    @GetMapping("/question_write")
    public ModelAndView go_question_write(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        return new ModelAndView("question/questionWrite").addObject("email", email);
    }

    @PostMapping("/write_question")
    public ModelAndView write_question(HttpServletRequest request, String q_title, String q_content, String q_hashtag){
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        System.out.println("write_question : " + email +  q_title + q_content + q_hashtag);

        boolean res = questionService.write_question(email, q_title, q_content, q_hashtag);

        if(res == true){
            System.out.println("insert 성공.");
        }

        return new ModelAndView("question/questionList").addObject("email", email);
    }

    @PostMapping("/write_answer")
    public ModelAndView write_answer(String email, String a_content, int question_id){
        System.out.println("write_answer : " + email + a_content + question_id);

        boolean res = questionService.write_answer(email, a_content, question_id);

        if(res == true){
            System.out.println("write_answer insert 성공.");
        }

        return new ModelAndView("question/questionList").addObject("email", email);
    }
}
