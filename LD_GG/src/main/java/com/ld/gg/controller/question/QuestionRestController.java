package com.ld.gg.controller.question;

import com.ld.gg.dto.question.AnswerDto;
import com.ld.gg.dto.question.QuestionDto;
import com.ld.gg.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequestMapping("/question")
@RestController
public class QuestionRestController {

    @Autowired
    QuestionService questionService;

    /* 질문글 전체 읽어오기 */
    @PostMapping("/select_list_all")
    public List<QuestionDto> select_list_all(){
        System.out.println("select_list...");

        List<QuestionDto> questionDtoList = questionService.select_list_all();

        if(questionDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return questionDtoList;
    }

    @PostMapping("/select_list")
    public List<QuestionDto> select_list(String email, int option){
        System.out.println("select_list : " + email + ", " + option);

        List<QuestionDto> questionDtoList = questionService.select_list(email, option);

        if(questionDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return questionDtoList;
    }

    @PostMapping("/select_answer")
    public List<AnswerDto> select_answer(int question_id){
        System.out.println("select_answer : " + question_id);

        List<AnswerDto>  answerDtoList = questionService.select_answer(question_id);

        if(answerDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return answerDtoList;
    }
}
