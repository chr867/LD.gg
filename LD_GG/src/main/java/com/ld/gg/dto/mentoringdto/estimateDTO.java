package com.ld.gg.dto.mentoringdto;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("estimate")
public class estimateDTO {
	private int estimate_id; //pk
	private String estimate_info;
	private String mentor_email;
	private String menti_email;
	private LocalDateTime estimate_date;
}
