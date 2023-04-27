package com.ld.gg.dao;

import com.ld.gg.dto.MemberDto;

public interface MemberDao {

	boolean join(MemberDto md);

	String getLoginInfo(String email);

	MemberDto getMemberInfo(String email);

	MemberDto getUserEmail(String email);
	
}
