package com.ld.gg.dto.question;

import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

import java.sql.Date;

@Data
@Accessors(chain = true)
@Alias("answer")
public class AnswerDto {
    private int answer_id;
    private String answer_content;
    private Date answer_date;
    private int question_id;
    private String answerer_id;
    private int answer_status;
    private String lol_account;
}
