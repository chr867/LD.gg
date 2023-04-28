package com.ld.gg.service;

import java.util.List;

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

	public boolean findMemberEmail(String email) {
		try {
			String checkEmail = mDao.getMemberEmail(email);
			if (checkEmail.equals(email)) {
				return false;
			} else {
				return true;
			}
		} catch (NullPointerException e) {
			return true;
		}

	}

	public List<MemberDto> findLolAccount(String lol_account) {
		return mDao.getMemberLolAccount(lol_account);
	}

	public boolean findMemberPhoneNum(String phone_num) {
		try {
			String checkPhone = mDao.getMemberPhoneNum(phone_num);
			if (checkPhone.equals(phone_num)) {
				return false;
			} else {
				return true;
			}
		} catch (NullPointerException e) {
			return true;
		}
	}

	public String find_email(String phone_num) {
		return mDao.get_email(phone_num);
	}

	public String find_password(String email, String phone_num) {
		List<MemberDto>check_account = mDao.check_account(email,phone_num);
		
		if(!check_account.isEmpty()) {
			PasswordGenerator passwordGenerator = new PasswordGenerator();
			String temporary_password = passwordGenerator.generateTemporaryPassword();
			System.out.println("임시 비밀번호: "+temporary_password);
			
			boolean result = update_password(email, temporary_password);
			System.out.println(result);
			if(result) {
				return temporary_password;
			}else {
				return null;
			}
		}
		return null;
	}
	
	private boolean update_password(String email, String password) {
		return mDao.update_password(email, password);
	}
	
	
}
