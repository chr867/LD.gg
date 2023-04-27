package com.ld.gg.dto.mentoringdto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomMentorDTO {
	private String menti_email;
    private String summoner_name;
    private String position_to_learn;
    private String champion_to_learn;
    private String target_tier;
    private String own_goal;
}
