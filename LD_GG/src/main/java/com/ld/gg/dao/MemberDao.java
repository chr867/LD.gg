package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.MemberDto;

public interface MemberDao {

	boolean join(MemberDto md);

	String getLoginInfo(String email);

	MemberDto getMemberInfo(String email);

	String getMemberEmail(String email);

	List<MemberDto> getMemberLolAccount(String lol_account);
	
}
