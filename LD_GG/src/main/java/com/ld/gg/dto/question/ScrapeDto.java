package com.ld.gg.dto.question;

import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.Alias;

@Data
@Accessors(chain = true)
@Alias("scrape")
public class ScrapeDto {
    private int question_id;
    private String email;
}
