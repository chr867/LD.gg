package com.ld.gg.controller.question;

import com.ld.gg.dto.question.AnswerDto;
import com.ld.gg.dto.question.QuestionDto;
import com.ld.gg.dto.question.ScrapeDto;
import com.ld.gg.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/select_list_test")
    public Map<String, List<?>> select_list_test(String email){
        Map<String, List<?>> question_map = new HashMap<>();

        question_map = questionService.select_list_test(email);

        return question_map;
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
    @PostMapping("/my_scrape")
    public int my_scrape(int question_id, String email){
        System.out.println("my_scrape : " + question_id + email);

        ScrapeDto scrapeDto = new ScrapeDto();

        scrapeDto.setQuestion_id(question_id);
        scrapeDto.setEmail(email);

        int res = questionService.my_scrape(scrapeDto);

        if(res < 0){
            System.out.println("restController question_scrape insert 실패!");
        }

        return res;
    }

    @PostMapping("/select_tag_one")
    public List<QuestionDto> select_tag_one(String tag1){
        System.out.println("select_tag_one : " + tag1);

        List<QuestionDto> questionDtoList = questionService.select_tag_one(tag1);

        if(questionDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return questionDtoList;
    }
    @PostMapping("/select_tag_by_two")
    public List<QuestionDto> select_tag_by_two(String tag1, String tag2){
        System.out.println("select_tag_one : " + tag1 +  tag2);

        List<QuestionDto> questionDtoList = questionService.select_tag_by_two(tag1, tag2);

        if(questionDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return questionDtoList;
    }
    @PostMapping("/select_tag_two")
    public List<QuestionDto> select_tag_two(String tag2){
        System.out.println("select_tag_two : " + tag2);

        List<QuestionDto> questionDtoList = questionService.select_tag_two(tag2);

        if(questionDtoList.size() == 0){
            System.out.println("select 결과 없음!!");
        }

        return questionDtoList;
    }
    @PostMapping("/my_unscrape")
    public int my_unscrape(String email, int question_id){
        System.out.println("my_unscrape : " + email + question_id);

        int res = questionService.my_unscrape(email, question_id);

        return res;
    }
}
