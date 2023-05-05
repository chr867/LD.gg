package com.ld.gg.userClass;
import java.time.LocalDateTime;

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
	
    public SessionListener() {
    }
    
	private SessionDao sDao;
    
    @Autowired
    public SessionListener(SessionDao sDao) {
    	this.sDao = sDao;
    }
    
    @Override
    public void sessionCreated(HttpSessionEvent event) {
    	
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
   	
        try {
            HttpSession session = event.getSession();
            //등록되어있는 빈을 사용할수 있도록 설정해준다
            // 세션이 삭제될 때 호출됩니다.
            LocalDateTime loginTime = LocalDateTime.now();
            String email = (String) session.getAttribute("email");
            if (email != null) {
            	
                HttpServletRequest request = (HttpServletRequest) session.getAttribute("request");
                String ipAddress = request != null ? request.getRemoteAddr() : "";
                String requestURI = request != null ? request.getRequestURI() : "";
                String httpMethod = request != null ? request.getMethod() : "";
                String userAgent = request != null ? request.getHeader("User-Agent") : "";
    			System.out.println("로그아웃 - 이메일: " + email + ", IP 주소: " + ipAddress + ", 로그아웃 시간: " + loginTime
    			        + ", Request URI: " + requestURI + ", HTTP Method: " + httpMethod + ", User-Agent: " + userAgent);
//                SessionDto sDto = new SessionDto();
//                sDto.setLogType("OUT");
//                sDto.setEmail(email);
//                sDto.setIpAddress(ipAddress);
//                sDto.setRequestURI(requestURI);
//                sDto.setHttpMethod(httpMethod);
//                sDto.setUserAgent(userAgent);
//                log.info("어드민 서비스 결과 : {}"+sDao);
//                Integer insertResult = sDao.insertSession(sDto);
//                log.info("로그아웃 기록 결과: {}", insertResult);
            }
        } catch (Exception e) {
            log.error("로그아웃 기록 중 오류 발생: {}", e.getMessage(), e);
        }
    }


    // 로그인 이력을 저장하는 메소드
    public void login(String email, HttpServletRequest request) {
        try {
			
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
			log.info("{}"+sDao);
			Integer insertResult = sDao.insertSession(sDto);
			log.info("로그인 기록 결과:" + insertResult);
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			
		}
    }
}



