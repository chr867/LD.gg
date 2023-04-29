package com.ld.gg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MemberDto;

public interface MemberDao {

	int join(MemberDto md);

	String getLoginInfo(String email);

	MemberDto getMemberInfo(String email);

	String getMemberEmail(String email);

	List<MemberDto> getMemberLolAccount(String lol_account);

	String getMemberPhoneNum(String phone_num);

	String getUserEmail(String phone_num);

	List<MemberDto> checkAccount(@Param("email") String email,@Param("phone_num") String phone_num);

	int updatePassword(@Param("email") String email, @Param("password") String password);
	
}
