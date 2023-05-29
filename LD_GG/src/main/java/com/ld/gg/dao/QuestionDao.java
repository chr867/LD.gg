package com.ld.gg.dao;

import com.ld.gg.dto.question.AnswerDto;
import com.ld.gg.dto.question.QuestionDto;
import com.ld.gg.dto.question.ScrapeDto;

import java.util.List;

public interface QuestionDao {
    List<QuestionDto> select_list_by_status(int status);

    List<QuestionDto> select_list_by_scrape(String email);

    List<QuestionDto> select_list_by_email(String email);

    List<QuestionDto> select_list_all();

    boolean write_question(QuestionDto questionDto);

    boolean write_answer(AnswerDto answerDto);

    List<AnswerDto> select_answer(int questionId);

    void update_question_status(int questionId);

    int my_scrape(ScrapeDto scrapeDto);
}
