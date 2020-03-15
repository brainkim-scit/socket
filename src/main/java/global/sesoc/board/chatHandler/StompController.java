package global.sesoc.board.chatHandler;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter;
import org.springframework.stereotype.Controller;

@Controller
public class StompController extends StompSessionHandlerAdapter {

	@MessageMapping("/TTT")
	@SendTo("/topic/message")
	public String ttt(String message) throws Exception {
		return message;
	}
}
