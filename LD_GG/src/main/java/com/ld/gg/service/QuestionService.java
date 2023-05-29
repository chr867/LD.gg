package com.ld.gg.service;

import com.ld.gg.dao.QuestionDao;
import com.ld.gg.dto.question.AnswerDto;
import com.ld.gg.dto.question.QuestionDto;
import com.ld.gg.dto.question.ScrapeDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class QuestionService {

    @Autowired
    QuestionDao qd;

    public List<QuestionDto> select_list(String email, int option) {

        List<QuestionDto> questionDtoList = null;

        /* 답변 완료 */
        if (option == 1){
            int status = 1;
            questionDtoList = qd.select_list_by_status(status);
        }
        /* 답변 대기 */
        else if (option == 2) {
            int status = 0;
            questionDtoList = qd.select_list_by_status(status);
        }
        /* 내 스크랩 */
        else if (option == 3) {
            questionDtoList = qd.select_list_by_scrape(email);
        }
        /* 내 질문 */
        else if (option == 4) {
            questionDtoList = qd.select_list_by_email(email);
        }

        return questionDtoList;
    }

    public List<QuestionDto> select_list_all() {
        List<QuestionDto> questionDtoList = null;

        questionDtoList = qd.select_list_all();

        return questionDtoList;
    }

    public boolean write_question(String email, String qTitle, String qContent, String qHashtag) {
        QuestionDto questionDto = new QuestionDto();
        List<String> hashtag_list = new ArrayList<>();
        String tag1 = "";
        String tag2 = "";

        if(qHashtag != ""){
            String[] hashtag = qHashtag.split("#");

            for (String tag : hashtag) {
                hashtag_list.add(tag.trim());
            }

            tag1 = hashtag_list.get(1);
            tag2 = hashtag_list.get(2);
        }

        questionDto.setEmail(email);
        questionDto.setQuestion_title(qTitle);
        questionDto.setQuestion_content(qContent);
        questionDto.setTag1(tag1);
        questionDto.setTag2(tag2);

        boolean res = qd.write_question(questionDto);

        return false;
    }

    public boolean write_answer(String email, String aContent, int questionId) {
        AnswerDto answerDto = new AnswerDto();

        answerDto.setAnswerer_id(email);
        answerDto.setAnswer_content(aContent);
        answerDto.setQuestion_id(questionId);

        boolean res = qd.write_answer(answerDto);

        if(res == true){
            qd.update_question_status(questionId);
        }

        return false;
    }

    public List<AnswerDto> select_answer(int questionId) {
        List<AnswerDto> answerDtoList = qd.select_answer(questionId);

        return answerDtoList;
    }

    public int my_scrape(ScrapeDto scrapeDto) {
        int res = qd.my_scrape(scrapeDto);

        System.out.println("sv res : " + res);

        return res;
    }

    public List<QuestionDto> select_tag_one(String tag1) {
        List<QuestionDto> questionDtoList = null;

        String tag = "";

        if (tag1.equals("top")) {
            tag = "탑";
        }
        else if (tag1.equals("mid")) {
            tag = "미드";
        }
        else if (tag1.equals("bottom")) {
            tag = "바텀";
        }
        else if (tag1.equals("jungle")) {
            tag = "정글";
        }
        else if (tag1.equals("supporter")) {
            tag = "서포터";
        }
        else tag = tag1;


        questionDtoList = qd.select_tag_one(tag);

        return questionDtoList;
    }

    public List<QuestionDto> select_tag_by_two(String tag1, String tag2) {
        List<QuestionDto> questionDtoList = null;

        String tag = "";

        if (tag1.equals("top")) {
            tag = "탑";
        }
        else if (tag1.equals("mid")) {
            tag = "미드";
        }
        else if (tag1.equals("bottom")) {
            tag = "바텀";
        }
        else if (tag1.equals("jungle")) {
            tag = "정글";
        }
        else if (tag1.equals("supporter")) {
            tag = "서포터";
        }
        else tag = tag1;


        System.out.println("ㅇㄹㅁ +" + tag1 + tag2 + tag);
        questionDtoList = qd.select_tag_by_two(tag, tag2);

        return questionDtoList;
    }

    public List<QuestionDto> select_tag_two(String tag2) {
        List<QuestionDto> questionDtoList = null;

        questionDtoList = qd.select_tag_two(tag2);

        return questionDtoList;
    }
}
