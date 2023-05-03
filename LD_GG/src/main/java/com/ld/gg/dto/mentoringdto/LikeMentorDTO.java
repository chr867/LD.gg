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
@Alias("likeMentor")
public class LikeMentorDTO {
	private String email;
	private String like_mentor;
}
