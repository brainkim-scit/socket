package global.sesoc.board.chatHandler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Repository
public class chatHandler extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(chatHandler.class);
	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		list.add(session);
		logger.info("{} 클라이언트 연결",session.getId()+","+session.getAttributes().get("username"));
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		for(WebSocketSession s : list) {
			if(!session.getId().equals(s.getId())) {
				s.sendMessage(new TextMessage(msg));
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("{} 클라이언트 연결 해제됨",session.getId()+","+session.getLocalAddress());
		list.remove(session);
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		logger.info("에러 발생 : "+exception.getMessage());
	}
}
