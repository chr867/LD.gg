package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.PaymentDao;
import com.ld.gg.dto.MemberDto;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao pd;

	public List<MemberDto> getUserInfo(String email) {
		List<MemberDto> md = pd.getUserInfo(email);
		return md;
	}

}
