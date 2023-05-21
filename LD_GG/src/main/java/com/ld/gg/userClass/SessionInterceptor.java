package com.ld.gg.userClass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class SessionInterceptor implements HandlerInterceptor {
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.info("세션인터셉터 동작중");
		Integer userType = (Integer) request.getSession().getAttribute("user_type");
        if (userType == null) { // 로그인하지 않은 경우
        	log.info("세션인터셉터 : 로그인을 해야합니다");
            response.sendRedirect("/"); // 홈페이지로 이동
            return false;
        }else if(userType == 4){
        	String email = (String) request.getSession().getAttribute("email");
        	log.info("정지된 회원입니다. : "+email);
        	response.sendRedirect("/"); // 홈페이지로 이동
        	return false;
        }else {
        	return true;
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
