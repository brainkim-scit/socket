package global.sesoc.board.chatHandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.stereotype.Controller;

import global.sesoc.board.vo.chat;

@Controller
public class StompController extends StompSessionHandlerAdapter {

	private final SimpMessagingTemplate template;
	
	@Autowired
	public StompController(SimpMessagingTemplate template) {
		this.template = template;
	}
	
	@MessageMapping("/TTT")
	public void ttt(chat chat) throws Exception {
		template.convertAndSend("/topic/message/"+chat.getRoomid(), chat);
	}
}
