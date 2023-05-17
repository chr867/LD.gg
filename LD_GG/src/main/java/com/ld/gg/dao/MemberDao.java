package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MemberDto;

public interface MemberDao {

	Integer join(MemberDto md);

	String getLoginInfo(String email);

	MemberDto getMemberInfo(String email);

	String getMemberEmail(String email);

	List<MemberDto> getMemberLolAccount(String lol_account);

	String getMemberPhoneNum(String phone_num);

	String getUserEmail(String phone_num);

	List<MemberDto> checkAccount(@Param("email") String email,@Param("phone_num") String phone_num);

	Integer updatePassword(@Param("email") String email, @Param("password") String password);

	Integer deleteAccount(String email);

	int updateUserType(@Param("email") String email, @Param("user_type") Integer user_type);

	List<MemberDto> getMemberLolAccountByKeyword(String lol_account_keyword);
	
}
