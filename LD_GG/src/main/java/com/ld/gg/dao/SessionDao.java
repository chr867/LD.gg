package com.ld.gg.dao;

import org.springframework.stereotype.Repository;

import com.ld.gg.dto.SessionDto;

public interface SessionDao {

	Integer insertSession(SessionDto sDto) ;

	

}
