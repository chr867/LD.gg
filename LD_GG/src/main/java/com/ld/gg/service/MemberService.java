package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
			Integer joinResult = mDao.join(md);
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
	//롤 닉네임 키워드로 회원정보 찾기
	public String findLolAccountByKeyword(String lol_account_keyword) throws JsonProcessingException {
		List<MemberDto> memberList = mDao.getMemberLolAccountByKeyword(lol_account_keyword);
		ObjectMapper objectMapper = new ObjectMapper();
		String mb_list_json = objectMapper.writeValueAsString(memberList);
		return mb_list_json;
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
			Integer success = mDao.updatePassword(email, password);
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
			// 비밀번호 매치확인
			boolean pwMatchResult = checkPassword(email, password);
			// update 결과 반환
			if (pwMatchResult) {
				boolean passwordChanged = updatePassword(email, changePw);
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
		try {
			// 비밀번호 매치확인
			boolean pwMatchResult = checkPassword(email, password);
			// Delete 결과 반환
			if (pwMatchResult) {
				boolean deleteResult = deleteAccount(email);
				return deleteResult;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	private boolean deleteAccount(String email) {
		try {
			Integer deleteResult = mDao.deleteAccount(email);
			if (deleteResult != 0) {
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

	public boolean changeUserType(String email, String password, Integer user_type) {
		try {
			boolean pwMatchResult = checkPassword(email, password);

			if (pwMatchResult) {
				boolean updateResult = updateUserType(email, user_type);
				return updateResult;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	private boolean updateUserType(String email, Integer user_type) {
		try {
			int updateResult = mDao.updateUserType(email, user_type);
			if (updateResult != 0) {
				return true;
			}
			return false;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	private boolean checkPassword(String email, String password) {
		try {
			String savedPassword = mDao.getLoginInfo(email);
			if (savedPassword.equals(password)) {
				log.info("패스워드 매치!");
				return true;
			} else {
				log.info("패스워드 불일치");
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

}
