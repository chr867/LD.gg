package com.ld.gg.dao;

import java.util.List;

import com.ld.gg.dto.MemberDto;

public interface PaymentDao {

	List<MemberDto> getUserInfo(String email);

}
