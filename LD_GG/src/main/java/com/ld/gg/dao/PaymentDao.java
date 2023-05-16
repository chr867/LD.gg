package com.ld.gg.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.payment.PaymentDto;
import com.ld.gg.dto.payment.PointDto;
import com.ld.gg.dto.payment.TransactionHistoryDTO;

public interface PaymentDao {

	List<MemberDto> getUserInfo(String email);

	PaymentDto checkOrderId(String orderId);

	int insertPaymentInfo(@Param("imp_uid") String imp_uid, @Param("merchant_uid") String merchant_uid, @Param("price") int price, @Param("email") String email, @Param("lol_account") String lol_account,
			@Param("phone_num") String phone_num, @Param("payment_status") String payment_status, @Param("payment_method") String payment_method);

	PointDto getPaymentInfo(String email);

	int checkBalance(String email);

	int updateBalance(int point, String email);

	Integer checkMentoringApplication(@Param("holder_email") String holder_email);

	List<MemberDto> getInfoForPayment(String lol_account);

	void insert_tx_history(TransactionHistoryDTO tx_history);

	void lowerPoint(String holder_email, int price);

}
