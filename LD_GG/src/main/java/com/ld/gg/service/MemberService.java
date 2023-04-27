package com.ld.gg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.MemberDao;
import com.ld.gg.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService {
	
	@Autowired
	private MemberDao mDao;
	
	public boolean join(MemberDto md) {

		return mDao.join(md);
	}

	public MemberDto login(MemberDto md) {
		
		String checkPw = mDao.getLoginInfo(md.getEmail());
		log.info(checkPw);
		if (checkPw != null) {
			if (checkPw.equals(md.getPassword())) {
				log.info("로그인 성공");
				return mDao.getMemberInfo(md.getEmail());
			} else {
				log.info("비번 오류");
				return null;
			}
		} else {
			log.info("아이디 오류");
			return null;
		}
	}

	public MemberDto findUserEmail(String email) {
		return mDao.getUserEmail(email);
	}

}
