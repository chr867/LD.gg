package com.ld.gg.dto.mentoringdto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class MentorProfileDTO {
    private String mentor_email;
    private String class_info;
    private String specialized_position;
    private String specialized_champion;
    private String contact_time;
    
}


