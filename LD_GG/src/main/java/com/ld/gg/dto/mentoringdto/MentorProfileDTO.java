package com.ld.gg.dto.mentoringdto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MentorProfileDTO {
    private String mentor_email;
    private String class_info;
    private String specialized_position;
    private String specialized_champion;
    private String contact_time;
    
}
