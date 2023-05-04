package com.ld.gg.userClass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ld.gg.dao.SessionDao;
import com.ld.gg.dto.SessionDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class SessionInterceptor implements HandlerInterceptor {
	
	@Autowired
	SessionDao sDao;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getSession().getAttribute("email") == null) { // 로그인하지 않은 경우
        	System.out.println("로그인을 해야합니다");
            response.sendRedirect("/"); // 홈페이지로 이동
            return false;
        }else {
        	String email = (String) request.getSession().getAttribute("email");
            String ipAddress = request.getRemoteAddr();
            String requestURI = request.getRequestURI();
            String httpMethod = request.getMethod();
            String userAgent = request.getHeader("User-Agent");
            log.info("email" + email);
            log.info("ipAddress"+ipAddress);
            log.info("requestURI"+requestURI);
            log.info("httpMethod"+httpMethod);
            log.info("userAgent"+userAgent);
            
            SessionDto sDto = new SessionDto();
            sDto.setEmail(email);
            sDto.setIpAddress(ipAddress);
            sDto.setRequestURI(requestURI);
            sDto.setHttpMethod(httpMethod);
            sDto.setUserAgent(userAgent);
            boolean insertResult = sDao.insertSession(sDto);
        	return insertResult; 
        }
    }

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
