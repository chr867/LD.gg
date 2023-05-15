package com.ld.gg.controller.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.service.PaymentService;
import com.ld.gg.dto.payment.PointDto;


@RestController
@RequestMapping("/wallet")
public class PaymentRestController {
	
	@Autowired
	private PaymentService ps;
	
	@PostMapping("/payment/kakaopay/success")
	public PointDto getKakaoResultSuccess(@RequestParam String imp_uid, @RequestParam String merchant_uid, @RequestParam int price, @RequestParam String email, @RequestParam String lol_account, @RequestParam String phone_num, @RequestParam String payment_status, @RequestParam String payment_method){
		PointDto ppd = ps.getPaymentInfo(imp_uid, merchant_uid, price, email, lol_account, phone_num, payment_status, payment_method);
		return ppd;
	}

	@PostMapping("/payment/kcp/success")
	public PointDto getKcpResultSuccess(@RequestParam String imp_uid, @RequestParam String merchant_uid, @RequestParam int price, @RequestParam String email, @RequestParam String lol_account, @RequestParam String phone_num, @RequestParam String payment_status, @RequestParam String payment_method){
		PointDto ppd = ps.getPaymentInfo(imp_uid, merchant_uid, price, email, lol_account, phone_num, payment_status, payment_method);
		return ppd;
	}
	
	@PostMapping("/payment/kakaopay/fail")
	public PointDto getKakaoResultFail(@RequestParam String imp_uid, @RequestParam String merchant_uid, @RequestParam int price, @RequestParam String email, @RequestParam String lol_account, @RequestParam String phone_num, @RequestParam String payment_status, @RequestParam String payment_method){
		PointDto ppd = ps.getPaymentInfo(imp_uid, merchant_uid, price, email, lol_account, phone_num, payment_status, payment_method);
		return ppd;
	}
	
	@PostMapping("/payment/kcp/fail")
	public PointDto getKcpResultFail(@RequestParam String imp_uid, @RequestParam String merchant_uid, @RequestParam int price, @RequestParam String email, @RequestParam String lol_account, @RequestParam String phone_num, @RequestParam String payment_status, @RequestParam String payment_method){
		PointDto ppd = ps.getPaymentInfo(imp_uid, merchant_uid, price, email, lol_account, phone_num, payment_status, payment_method);
		return ppd;
	}
	
	@PostMapping("/payment/mentoring-application")//멘토 수업 신청 시 멘티의 잔액 확인
	public boolean checkMentoringApplication(@RequestParam String holder_email, @RequestParam int price) {
		boolean result = ps.checkMentoringApplication(holder_email, price);
		return result;
	}
	
}
