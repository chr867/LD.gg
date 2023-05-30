package com.ld.gg.controller.payment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ld.gg.service.PaymentService;
import com.ld.gg.dto.payment.PointDto;
import com.ld.gg.dto.payment.UsageHistoryDto;


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
	
	@PostMapping("/payment/getCharge")
	public List<UsageHistoryDto> getCharge(@RequestParam String email){
		List<UsageHistoryDto> uhd = ps.getCharge(email);
		System.out.println("uhd : " + uhd);
		return uhd;
	}
	
}
