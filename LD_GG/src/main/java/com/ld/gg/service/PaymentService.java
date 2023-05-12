package com.ld.gg.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.PaymentDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.payment.PaymentDto;
import com.ld.gg.dto.payment.PointDto;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao PD;
	
	@Autowired
	private MerchantIdGenerator MIG;
	
	@Autowired
	private DataSource datasource;

	public List<MemberDto> getUserInfo(String email) {
		List<MemberDto> md = PD.getUserInfo(email);
		return md;
	}

	public String getOrderId() {
		String orderId = MIG.generateOrderId();
		PaymentDto pd = PD.checkOrderId(orderId);
		boolean result = false;
		if(pd != null) {
			result = true;
		}else {
			result = false;
		}
		if(result != true) {
			return orderId;
		}else {
			orderId = MIG.generateOrderId();
			return orderId;
		}
	}

	public PointDto getPaymentInfo(String imp_uid, String merchant_uid, int price, String email,
			String lol_account, String phone_num, String payment_status, String payment_method) {
		int resultInt = PD.insertPaymentInfo(imp_uid, merchant_uid, price, email, lol_account, phone_num, payment_status, payment_method);
		
		boolean result = false;
		
		if(resultInt == 1) {//Insert 결과가 1일시, true
			result = true;
		}else {
			result = false;
		}
		
		if(result) {//true일 시, 잔액 조회 후 잔액과 충전금을 합산 -> 잔액 포인트 갱신(update) -> 결제자의 이름과 결제 후 보유 잔액 반환
			int point = PD.checkBalance(email);
			point = point + price;
			int pointResult = PD.updateBalance(point);
			PointDto ppd = PD.getPaymentInfo(email);
			
			Connection con = null;
	        try {
	            con = datasource.getConnection();
	            con.commit(); // 트랜잭션 커밋
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (con != null) {
	                try {
	                    con.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
			
			return ppd;
		}else {
			return null;
		}
	}

}
