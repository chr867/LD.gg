package com.ld.gg.userClass;

import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ld.gg.dao.SessionDao;
import com.ld.gg.dto.SessionDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebListener
@Component
public class SessionListener implements HttpSessionListener {

	private static final ConcurrentHashMap<String, HttpSession> sessions = new ConcurrentHashMap<>();
	private static final ConcurrentHashMap<String, HttpSession> emailSessions = new ConcurrentHashMap<>();

	@Autowired
	private SessionDao sDao;

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		log.info("세션정보 : {}",session);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		try {
			HttpSession session = event.getSession();
			String email = (String) session.getAttribute("email");

			LocalDateTime logoutTime = LocalDateTime.now();
			if (email != null) {
				HttpServletRequest request = (HttpServletRequest) session.getAttribute("request");
				String ipAddress = request != null ? request.getRemoteAddr() : "";
				String requestURI = request != null ? request.getRequestURI() : "";
				String httpMethod = request != null ? request.getMethod() : "";
				String userAgent = request != null ? request.getHeader("User-Agent") : "";
				log.info("로그아웃 - 이메일: " + email + ", IP 주소: " + ipAddress + ", 로그아웃 시간: " + logoutTime
						+ ", Request URI: " + requestURI + ", HTTP Method: " + httpMethod + ", User-Agent: " + userAgent);
				log.info("세션디스트로이드 세션 삭제 시작");
				
				session.invalidate(); 
				emailSessions.remove(email);
				sessions.remove(email);
			}
		} catch (Exception e) {
			log.error("세션 삭제 중 에러 발생", e);
		}
	}

	// 로그인 이력을 저장하는 메소드
	public void login(String email, HttpServletRequest request) {
	    try {
	        HttpSession session = request.getSession();
	        HttpSession prevSession = emailSessions.putIfAbsent(email, session);
	        if (prevSession != null) {
	            log.warn("중복 로그인 - 이메일: {}, 세션을 제거합니다.", email);
	            prevSession.invalidate();
	        } else {
	            sessions.put(email, session);
	        }

	        LocalDateTime loginTime = LocalDateTime.now();
	        String ipAddress = request != null ? request.getRemoteAddr() : "";
	        String requestURI = request != null ? request.getRequestURI() : "";
	        String httpMethod = request != null ? request.getMethod() : "";
	        String userAgent = request != null ? request.getHeader("User-Agent") : "";

	        log.info("로그인 - 이메일: " + email + ", IP 주소: " + ipAddress + ", 로그인 시간: " + loginTime
	                + ", Request URI: " + requestURI + ", HTTP Method: " + httpMethod + ", User-Agent: " + userAgent);

	        SessionDto sDto = new SessionDto();
	        sDto.setLogType("IN");
	        sDto.setEmail(email);
	        sDto.setIpAddress(ipAddress);
	        sDto.setRequestURI(requestURI);
	        sDto.setHttpMethod(httpMethod);
	        sDto.setUserAgent(userAgent);
	        Integer insertResult = sDao.insertSession(sDto);
	        log.info("로그인 기록 결과:" + insertResult);
	    } catch (Exception e) {
	        System.out.println(e);
	        e.printStackTrace();
	    }
	}
	
	// 로그아웃 메소드
	public void logout(String email){
		try {
			HttpSession session = sessions.get(email);
			if (session != null) {
				log.info("로그아웃 메소드 세션 삭제 시작");
				
			    emailSessions.remove(email);
				sessions.remove(email); 
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
	}

}
