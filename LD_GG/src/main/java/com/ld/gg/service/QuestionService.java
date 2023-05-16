package com.ld.gg.service;

import com.ld.gg.dao.QuestionDao;
import com.ld.gg.dto.question.AnswerDto;
import com.ld.gg.dto.question.QuestionDto;
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
}
