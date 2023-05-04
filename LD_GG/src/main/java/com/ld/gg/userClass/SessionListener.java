package com.ld.gg.userClass;
import java.time.LocalDateTime;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.AdminDao;
import com.ld.gg.dao.SessionDao;
import com.ld.gg.dto.SessionDto;
import com.ld.gg.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebListener
@Component
public class SessionListener implements HttpSessionListener {
	
	@Autowired
	private AdminService as;
	
	@Autowired
	private AdminDao aDao;

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        // 세션이 생성될 때 호출됩니다.
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
    	
        try {
			HttpSession session = event.getSession();
			// 세션이 삭제될 때 호출됩니다.
			String email = (String) session.getAttribute("email");
			if (email != null) {

			    LocalDateTime logoutTime = LocalDateTime.now();

			    HttpServletRequest request = (HttpServletRequest) session.getAttribute("request");
			    String ipAddress = request != null ? request.getRemoteAddr() : "";
			    String requestURI = request != null ? request.getRequestURI() : "";
			    String httpMethod = request != null ? request.getMethod() : "";
			    String userAgent = request != null ? request.getHeader("User-Agent") : "";

			    System.out.println("로그아웃 - 이메일: " + email + ", IP 주소: " + ipAddress + ", 로그아웃 시간: " + logoutTime
			            + ", Request URI: " + requestURI + ", HTTP Method: " + httpMethod + ", User-Agent: " + userAgent);
			    
			    SessionDto sDto = new SessionDto();
			    sDto.setLogType("OUT");
			    sDto.setEmail(email);
			    
			    log.info("세션DTO 결과:"+ sDto);
			    log.info("{}"+as);
			    log.info("{}"+aDao);
//			    boolean insertResult = as.insertSession(sDto);
//			    log.info("로그아웃 기록 결과:" + insertResult);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    // 로그인 이력을 저장하는 메소드
    public void login(String email, HttpServletRequest request) {
        try {
			// 현재 시간을 구합니다.
			LocalDateTime loginTime = LocalDateTime.now();

			String ipAddress = request != null ? request.getRemoteAddr() : "";
			String requestURI = request != null ? request.getRequestURI() : "";
			String httpMethod = request != null ? request.getMethod() : "";
			String userAgent = request != null ? request.getHeader("User-Agent") : "";

			System.out.println("로그인 - 이메일: " + email + ", IP 주소: " + ipAddress + ", 로그인 시간: " + loginTime
			        + ", Request URI: " + requestURI + ", HTTP Method: " + httpMethod + ", User-Agent: " + userAgent);
			
			SessionDto sDto = new SessionDto();
			sDto.setLogType("IN");
			sDto.setEmail(email);
			sDto.setIpAddress(ipAddress);
			sDto.setRequestURI(requestURI);
			sDto.setHttpMethod(httpMethod);
			sDto.setUserAgent(userAgent);
			log.info("세션DTO 결과:"+ sDto);
			log.info("{}"+as);
			boolean insertResult = as.insertSession(sDto);
			log.info("로그인 기록 결과:" + insertResult);
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			
		}
    }
}



