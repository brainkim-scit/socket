package global.sesoc.board.controllers;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import global.sesoc.board.vo.member;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@GetMapping("/")
	public String index(HttpSession session) {
		logger.info("첫 페이지");
		return "index";
	}
	
   @GetMapping("/chat")
	public String chat(String roomid, Model model) {
	   	model.addAttribute("roomid", roomid);
		return "chat";
    }
}
