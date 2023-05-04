package com.ld.gg.dao;

import org.springframework.stereotype.Repository;

import com.ld.gg.dto.SessionDto;

@Repository
public interface SessionDao {

	Integer insertSession(SessionDto sDto) ;

	

}
