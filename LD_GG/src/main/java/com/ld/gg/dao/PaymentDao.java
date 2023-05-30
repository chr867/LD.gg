package com.ld.gg.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.payment.PaymentDto;
import com.ld.gg.dto.payment.PointDto;
import com.ld.gg.dto.payment.TradeDto;
import com.ld.gg.dto.payment.TransactionHistoryDTO;
import com.ld.gg.dto.payment.UsageHistoryDto;

public interface PaymentDao {

	List<MemberDto> getUserInfo(String email);

	PaymentDto checkOrderId(String orderId);

	int insertPaymentInfo(@Param("imp_uid") String imp_uid, @Param("merchant_uid") String merchant_uid, @Param("price") int price, @Param("email") String email, @Param("lol_account") String lol_account,
			@Param("phone_num") String phone_num, @Param("payment_status") String payment_status, @Param("payment_method") String payment_method);

	PointDto getPaymentInfo(String email);

	int checkBalance(String email);

	void updateBalance(@Param("email")String email, @Param("point") int point);

	Integer checkMentoringApplication(@Param("holder_email") String holder_email);

	List<MemberDto> getInfoForPayment(String email);
	
	//트랜잭션 히스토리에 거래내역 저장
	int insert_tx_history(TransactionHistoryDTO tx_history);
	//이메일을 받아서 포인트 테이블에 포인트 0인 상태로 추가
	void insert_point_0(String holder_email);
	//멤버테이블에 있지만 포인트테이블에 없는 사람들 포인트 테이블에 저장
	void renewal_point_0();

	PointDto getBalance(@Param("email") String email);

	List<UsageHistoryDto> getCharge(@Param("email") String email);

	void updatePayBalance(@Param("holder_email")String holder_email, @Param("point") int point, @Param("price") int price);

	TradeDto updateTrade(TransactionHistoryDTO tx_history);

}
