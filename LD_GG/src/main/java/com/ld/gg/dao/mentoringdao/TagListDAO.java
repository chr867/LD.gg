package com.ld.gg.dao.mentoringdao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ld.gg.dto.mentoringdto.TagListDTO;

@Mapper
public interface TagListDAO {
	List<TagListDTO> select_all_tag();
	List<TagListDTO> select_by_tag_type(String tag_type);
	TagListDTO select_by_id_tag(int tag_id);
}
