package global.sesoc.board.chatHandler;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import global.sesoc.board.vo.member;

public class chatInterceptor extends HttpSessionHandshakeInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(chatInterceptor.class);

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		
		logger.info("beforeHandshake : 소켓 보내는 중...");
		
		ServletServerHttpRequest sshr = (ServletServerHttpRequest) request;
		
		HttpServletRequest hsr = sshr.getServletRequest();
		
		member user = (member) hsr.getAttribute("member");
		
		String username = user.getUsername();
		
		attributes.put("username", username);
		
		logger.info(username+"접속을 요청 했습니다");
		logger.info("ip주소 : "+hsr.getLocalAddr());
		
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}
	
}
