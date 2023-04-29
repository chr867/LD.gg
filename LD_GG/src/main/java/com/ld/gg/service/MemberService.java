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
		try {
			int joinResult = mDao.join(md);
			if (joinResult != 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	public MemberDto login(MemberDto member) {
		try {
			String storedPassword = mDao.getLoginInfo(member.getEmail());

			if (storedPassword != null) {
				if (storedPassword.equals(member.getPassword())) {
					log.info("로그인 성공");
					return mDao.getMemberInfo(member.getEmail());
				} else {
					log.info("비밀번호 오류");
					return null;
				}
			} else {
				log.info("아이디 오류");
				return null;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}

	public boolean findMemberEmail(String email) {
		try {
			String memberEmail = mDao.getMemberEmail(email);

			if (memberEmail.equals(email)) {
				// 입력한 이메일과 일치하는 회원이 있을 경우
				return false;
			} else {
				// 일치하는 회원이 없을 경우
				return true;
			}
		} catch (NullPointerException e) {
			// 이메일이 null인 경우
			return true;
		}
	}

	public List<MemberDto> findLolAccount(String lol_account) {
		try {
			return mDao.getMemberLolAccount(lol_account);
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}

	public boolean findMemberPhoneNum(String phone_num) {
		try {
			String memberPhoneNumber = mDao.getMemberPhoneNum(phone_num);

			if (memberPhoneNumber.equals(phone_num)) {
				// 입력한 전화번호와 일치하는 회원이 있을 경우
				return false;
			} else {
				// 일치하는 회원이 없을 경우
				return true;
			}
		} catch (NullPointerException e) {
			System.out.println(e);
			e.printStackTrace();
			return true;
		}
	}

	public String findEmail(String phone_num) {
		try {
			return mDao.getUserEmail(phone_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}

	private boolean updatePassword(String email, String password) {
		try {
			// 비밀번호 업데이트 로직
			int success = mDao.updatePassword(email, password);
			System.out.println("success : " + success);
			if (success != 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	public String findPassword(String email, String phone_num) {
		try {
			// 이메일, 전화번호 확인
			List<MemberDto> accountList = mDao.checkAccount(email, phone_num);

			if (!accountList.isEmpty()) {
				// 임시 비밀번호 발급
				PasswordGenerator passwordGenerator = new PasswordGenerator();
				String temporaryPassword = passwordGenerator.generateTemporaryPassword();
				System.out.println("임시 비밀번호: " + temporaryPassword);

				// 비밀번호 업데이트
				boolean passwordUpdated = updatePassword(email, temporaryPassword);
				System.out.println("비밀번호 업데이트 결과: " + passwordUpdated);

				// 업데이트 성공 시 임시 비밀번호 반환
				if (passwordUpdated) {
					return temporaryPassword;
				}
			}
			return null;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}

	}

	public boolean changePassword(String email, String password, String changePw) {
		try {
			// 사용자 정보 조회
			String savedPassword = mDao.getLoginInfo(email);

			// 비밀번호 매치 확인 후 결과 반환
			if (savedPassword.equals(password)) {
				log.info("비밀번호 변경 패스워드 매치!");
				boolean passwordChanged = updatePassword(email, changePw);
				log.info("비밀번호 체인지 결과: " + passwordChanged);
				return passwordChanged;
			} else {
				return false;
			}
		} catch (NullPointerException e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	public boolean dropMember(String email, String password) {
		
		// 사용자 정보 조회
		String savedPassword = mDao.getLoginInfo(email);

		// 비밀번호 매치 확인 후 결과 반환
		if (savedPassword.equals(password)) {
			log.info("회원탈퇴 패스워드 매치!");
			boolean deleteResult = deleteAccount(email);
			return deleteResult;
		} else {
			return false;
		}
	}
	
	private boolean deleteAccount(String email) {
		int deleteResult = mDao.deleteAccount(email);
		if(deleteResult != 0) {
			return true;
		}else {
			return false;
		}
	}

}
