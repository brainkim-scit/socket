package global.sesoc.board.controllers;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import global.sesoc.board.dao.guestbook.guestbookDAO;
import global.sesoc.board.vo.guestbook;

@Controller
public class GuestbookController {

	@Autowired
	private guestbookDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(GuestbookController.class);
	
	@GetMapping("/guestbook")
	public String guestbookView(Model model) {
		ArrayList<guestbook> list = dao.selectAll();
		model.addAttribute("list", list);
		
		return "guestbook/guestbook";
	}
	
	@GetMapping("/search")
	public String search(String select, String aim, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("select", select);
		map.put("aim", aim);
		ArrayList<guestbook> list = dao.search(map);
		model.addAttribute("list", list);
		return "guestbook/guestbook";
	}
	
	@PostMapping("/guestbook")
	public String guestbook(guestbook guest, Model model) {
		int result = dao.insertGuest(guest);
		model.addAttribute("result", result);
	
		return "redirect:/guestbook";
	}
	
	@GetMapping("/guest")
	public String guest(int seqno, Model model) {
		guestbook vo = dao.select(seqno);
		model.addAttribute("vo", vo);

		return "guestbook/guestLogin";
	}
	
	@PostMapping("/guestlogin")
	public String login(guestbook vo, Model model) {
		model.addAttribute("vo", vo);
		return "guestbook/guestModify";
	}
	
	@GetMapping("/delete")
	public String delete(int seqno) {
		dao.delete(seqno);
		
		return "redirect:/";
	}
	
	@PostMapping("/guestmodify")
	public String modify(guestbook guest) {
		dao.update(guest);
		
		return "redirect:/";
	}
}
