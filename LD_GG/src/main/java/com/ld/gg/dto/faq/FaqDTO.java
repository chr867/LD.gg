package com.ld.gg.dto.faq;

import org.apache.ibatis.type.Alias;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("faq")
public class FaqDTO {
	private int faq_id; //pk
    private String questions_list;
    private String answers_list;
}
