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
    private String top_specialized_champion;
    private String jg_specialized_champion;
    private String mid_specialized_champion;
    private String ad_specialized_champion;
    private String sup_specialized_champion;
    private String contact_time;
    private String careers;
    private String recom_ment;
    private int num_of_lessons;
    private int num_of_reviews;
    private int num_of_likes;
    private float total_grade;
    private String lol_account;
    private String tier;
    private int tier_int;
    private int s_level;
    private int games;
    private int lp;
    private String profile_icon_id;
}


