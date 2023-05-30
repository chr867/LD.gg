package com.ld.gg.controller.payment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dto.MemberDto;
import com.ld.gg.dto.payment.PointDto;
import com.ld.gg.service.PaymentService;

@Controller
@RequestMapping("/wallet")
public class PaymentController {
	
	@Autowired
	private PaymentService ps;
	
	@GetMapping("/payment")
	public String goPayment(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		PointDto pd = ps.getBalance(email);
		model.addAttribute("buyer", pd);
		System.out.println("pd : " + pd);
		System.out.println("model : " + model);
		return "/wallet/payment";
	}
	
	@PostMapping("/payment/userinfo")
	@ResponseBody
	public MemberDto getUserInfo(@RequestParam String email) {
	    MemberDto md = ps.getUserInfo(email);
	    return md;
	}

	@PostMapping("/payment/getOrderId")
	@ResponseBody
	public String getOrderId() {
		String orderId = ps.getOrderId();
		return orderId;
	}
	
}
