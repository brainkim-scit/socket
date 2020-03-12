package global.sesoc.board.controllers;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.board.dao.board.boardDAO;
import global.sesoc.board.dao.reply.replyDAO;
import global.sesoc.board.util.FileService;
import global.sesoc.board.util.PageNavigator;
import global.sesoc.board.util.ReplyPageNavigator;
import global.sesoc.board.vo.board;
import global.sesoc.board.vo.member;
import global.sesoc.board.vo.reply;

@Controller
public class BoardController {
	
	@Autowired
	boardDAO dao;
	
	@Autowired
	replyDAO rdao;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
//	final int countPerPage = 10;
	final String uploadPath = "/uploadPath";
	
	@GetMapping("/boardlist")
	public String boardListView(
			@RequestParam(value = "select", defaultValue = "title") String select, 
			@RequestParam(value = "aim", defaultValue = "") String aim,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			Model model,
			HttpSession session) {
		
		if(currentPage<1) {
			currentPage = 1;
		}
		
		int totalRecordCount = dao.getBoardCount(select, aim);
		
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		ArrayList<board> boardlist = dao.selectAll(select, aim, navi.getStartRecord(), navi.getCountPerPage());

		logger.info("게시판 리스트 출력");
		logger.info("검색어 : "+select+", "+aim+", "+currentPage);
		logger.info("페이지 네비 : "+navi);
		logger.info("게시판 리스트 : "+boardlist);
		
		//댓글 개수
		ArrayList<Integer> replyCount = rdao.count();
		
		//구버전
//		int start = currentPage * countPerPage - countPerPage + 1;
//		int end = currentPage * countPerPage;
//		
//		ArrayList<board> list = dao.selectAll(select, aim, start, end);
//		int totalPage = (totalRecordCount % countPerPage > 0)?
//				(totalRecordCount/countPerPage)+1 : (totalRecordCount/countPerPage);
		
		// 게시글 보고 목록으로 돌아갈 때 해당 페이지를 볼 수 있도록
		session.setAttribute("select", select);
		session.setAttribute("aim", aim);
		session.setAttribute("currentPage", currentPage);
		
		//페이징 처리용
		model.addAttribute("navi", navi);
		model.addAttribute("boardlist", boardlist);
		model.addAttribute("replyCount", replyCount);
//		model.addAttribute("totalPage", totalPage);
//		model.addAttribute("totalRecordCount", totalRecordCount);
//		model.addAttribute("countPerPage", countPerPage);
		return "board/boardlist";
	}
	
	@GetMapping("/write")
	public String boardWriteView() {
		return "board/board";
	}
	
	@PostMapping("/write")
	public String boardWrite(board board, MultipartFile upload, HttpSession session) {
		
		String savedFilename = FileService.saveFile(upload, uploadPath);
		String originalFilename = upload.getOriginalFilename();

		board.setOriginalfilename(originalFilename);
		board.setSavedfilename(savedFilename);
		
		dao.insertBoard(board);
		return "redirect:boardlist";
	}
	
	@GetMapping("/getin")
	public String boardIn(int boardno, Model model) {
		board board = dao.select(boardno);
		dao.count(board);
		logger.info("게시판번호 : " + boardno);
		model.addAttribute("board", board);
		return "board/boardDetail";
	}
	
	@GetMapping("/boardModify")
	public String modifyView(int boardno, Model model) {
		board board = dao.select(boardno);
		model.addAttribute("board", board);
		return "board/boardModify";
	}
	
	@PostMapping("/boardModify")
	public String boardModify(board board, MultipartFile upload, HttpSession session, RedirectAttributes rttr) {
		member member = (member)session.getAttribute("member");
		board.setWriter(member.getId());
		
		if(!upload.isEmpty()) {
			FileService.deleteFile(uploadPath+"/"+dao.select(board.getBoardno()).getSavedfilename());
			String savedfilename = FileService.saveFile(upload, uploadPath); 
			String originalfilename = upload.getOriginalFilename();
			board.setOriginalfilename(originalfilename);
			board.setSavedfilename(savedfilename);
		}
		int result = dao.update(board);
		
		rttr.addFlashAttribute("modifyResult", result);
		
		return "redirect:getin?boardno="+board.getBoardno()+"replyPage=1";
	}
	
	@GetMapping("/boardDelete")
	public String boardDelete(board board, HttpSession session, RedirectAttributes rttr) {
		member member = (member)session.getAttribute("member");
		board.setWriter(member.getId());
		
		board del = dao.select(board.getBoardno());
		
		String fullpath = uploadPath + "/" + del.getSavedfilename();
		FileService.deleteFile(fullpath);
		
		int result = dao.delete(board);
		rttr.addFlashAttribute("deleteResult", result);
		return "redirect:boardlist";
	}
	
	@GetMapping("/download")
	public String download(int boardno, HttpServletResponse response) {
		board board = dao.select(boardno);
		String savedfilename = board.getSavedfilename();
		String originalfilename = board.getOriginalfilename();
		try {
			response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(originalfilename, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String fullpath = uploadPath + "/" + savedfilename;
		FileInputStream in = null;
		ServletOutputStream out = null;
		
		try {
			in = new FileInputStream(fullpath);
			out = response.getOutputStream();
			FileCopyUtils.copy(in, out);
			in.close();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GetMapping("/deleteFile")
	public String deleteFile(int boardno, Model model) {
		board board = dao.select(boardno);
		String fullpath = uploadPath + "/" + board.getSavedfilename();
		boolean del = FileService.deleteFile(fullpath);
		if(del) {
			board.setOriginalfilename(null);
			board.setSavedfilename(null);
		}
		dao.update(board);
		model.addAttribute("board",board);
		model.addAttribute("result", 1);
		return "board/boardModify";
	}
	
//	@GetMapping("/searchBoard")
//	public String searchBoard(String select, String aim, Model model) {
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("select", select);
//		map.put("aim", aim);
//		ArrayList<board> list = dao.search(map);
//		model.addAttribute("list", list);
//		return "board/boardlist";
//	}
}
