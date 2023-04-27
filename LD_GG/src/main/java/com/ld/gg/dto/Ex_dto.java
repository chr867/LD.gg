package com.ld.gg.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Alias("ex")
public class Ex_dto {
	private int id;
	private String name;
	private int age;
}
