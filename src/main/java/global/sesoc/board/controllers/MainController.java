package global.sesoc.board.controllers;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@GetMapping("/")
	public String index(HttpSession session) {
		logger.info("첫 페이지");
		session.removeAttribute("select");
		session.removeAttribute("aim");
		session.removeAttribute("currentPage");
		return "index";
	}
	
   @GetMapping("/chat")
	public String chat() {
		return "chat";
    }
}
