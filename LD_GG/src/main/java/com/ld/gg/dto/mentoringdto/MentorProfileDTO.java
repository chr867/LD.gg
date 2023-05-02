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
@Alias("mentorProfile")
public class MentorProfileDTO {
    private String mentor_email; //pk
    private String about_mentor;
    private String specialized_position;
    private String specialized_champion;
    private String contact_time;
    private String careers;
    private String recom_ment;
    private int num_of_lessons;
    private int num_of_reviews;
    private int num_of_likes;
    private float total_grade;
    
}


