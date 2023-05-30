package com.ld.gg.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.MemberDao;
import com.ld.gg.dao.PaymentDao;
import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.payment.PaymentDto;
import com.ld.gg.dto.payment.PointDto;
import com.ld.gg.dto.payment.TradeDto;
import com.ld.gg.dto.payment.TransactionHistoryDTO;
import com.ld.gg.dto.payment.UsageHistoryDto;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao PD;
	
	@Autowired
	private MerchantIdGenerator MIG;
	
	@Autowired
	private DataSource datasource;
	
	@Autowired
	private MemberDao mbdao;

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
			PD.updateBalance(email,point);
			PointDto ppd = PD.getPaymentInfo(email);
			
			return ppd;
		}else {
			return null;
		}
	}

	public Boolean checkMentoringApplication(String holder_email, int price) {
	    int point = 0;
	    Integer pointBalance = PD.checkMentoringApplication(holder_email);
	    if (pointBalance == null) {
	        // null 값을 반환하는 경우에 대한 처리
	        return false; // 예시로 false를 반환하도록 설정
	    }
	    point = pointBalance.intValue();
	    if (point < price) {
	        return false;
	    } else {
	    	PD.updatePayBalance(holder_email, point, price);
	        return true;
	    }
	}

	public List<MemberDto> getInfoForPayment(String email) {
		List<MemberDto> md = PD.getInfoForPayment(email);
		return md;
	}
	
	//트랜잭션 히스토리에 거래내역 저장
	public void insert_tx_history(TransactionHistoryDTO tx_history) {
		String menti_lol_account = tx_history.getSender_id();
		List<MemberDto> mbdto = mbdao.getUserLolAccount(menti_lol_account);
		String menti_email = mbdto.get(0).getEmail();
		tx_history.setSender_id(menti_email);
		int checknum = PD.insert_tx_history(tx_history);
		if(checknum == 1) {
			PD.updateTrade(tx_history);
		}
	}
	//이메일을 받아서 포인트 테이블에 포인트 0으로 저장(회원가입 시)
	public void insert_point_0(String holder_email) {
		PD.insert_point_0(holder_email);
	}
	//멤버테이블에 있지만 포인트테이블에 없는 사람들 포인트 테이블에 추가
	public void renewal_point_0() {
		PD.renewal_point_0();
	}

	public PointDto getBalance(String email) {
		return PD.getBalance(email);
	}

	public List<UsageHistoryDto> getCharge(String email) {
		return PD.getCharge(email);
	}
}
