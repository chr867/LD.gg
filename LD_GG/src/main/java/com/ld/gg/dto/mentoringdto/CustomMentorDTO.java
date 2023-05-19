package com.ld.gg.dto.mentoringdto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("customMentor")
public class CustomMentorDTO {
	private String menti_email; //pk
    private String lol_account;
    private String position_to_learn;
    private String champion_to_learn;
    private String target_tier;
}
