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
@Alias("tagList")
public class TagListDTO {
	private int tag_id; //pk
	private String tag_info;
	private String tag_type;
	private String mentor_version;
}
