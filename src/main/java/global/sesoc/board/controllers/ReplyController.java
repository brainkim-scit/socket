package global.sesoc.board.controllers;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.board.dao.reply.replyDAO;
import global.sesoc.board.util.PageNavigator;
import global.sesoc.board.vo.member;
import global.sesoc.board.vo.reply;

@RestController
public class ReplyController {

	@Autowired
	replyDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@PostMapping("/reply")
	public int insertReply(reply reply, HttpSession session) {
		logger.info("댓글 추가 : "+reply);
		member member = (member) session.getAttribute("member");
		reply.setWriter(member.getId());
		int result = dao.insertReply(reply);
		return result;
	}
	
	@GetMapping("/replyList")
	public HashMap<String, Object> listAll(int boardno, @RequestParam(value = "currentPage", defaultValue = "1")int currentPage) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int totalRecordCount = dao.getTotalCount(boardno);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		ArrayList<reply> list = dao.selectAll(boardno, navi.getStartRecord(), navi.getCountPerPage());
		
		map.put("navi", navi);
		map.put("list", list);
		
		return map;
	}
	
	@GetMapping("/deleteReply")
	public int deleteReply(reply reply, HttpSession session, RedirectAttributes rttr) {
		logger.info("댓글 삭제 : "+reply);
		member member = (member) session.getAttribute("member");
		reply.setWriter(member.getId());
		
		return dao.deleteReply(reply);
	}
	
	@PostMapping("/modifyReply")
	public int modifyReply(reply reply, HttpSession session) {
		logger.info("댓글 수정 : "+reply);
		member member = (member) session.getAttribute("member");
		reply.setWriter(member.getId());
		
		return dao.modifyReply(reply);
	}
}
