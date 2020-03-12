package global.sesoc.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import global.sesoc.board.vo.member;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("loginInterceptor");
		HttpSession session = request.getSession();
		member member = (member) session.getAttribute("member");
		if(member==null) {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/login");
			return false;
		}else return true;
	}
	
}
