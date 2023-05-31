package com.ld.gg.dto.question;

import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

import java.sql.Date;

@Data
@Accessors(chain = true)
@Alias("question_post")
public class QuestionDto {
    private int question_id;
    private String question_content;
    private String question_title;
    private Date question_date;
    private String email;
    private int status;
    private String tag1;
    private String tag2;
    private String lol_account;
    private String profile_icon_id;
}
