package global.sesoc.board.controllers;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.board.dao.member.memberDAO;
import global.sesoc.board.vo.member;

@Controller
public class MemberController {

	@Autowired
	private memberDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@GetMapping("/signup")
	public String signupView() {
		logger.info("회원가입 페이지 이동");
		return "member/signup";
	}

	@PostMapping("/signup")
	public String signup(member m, Model model) {
		logger.info("회원가입 : "+m);
		int result = dao.signup(m);
		model.addAttribute("result",result);
		return "redirect:/";
	}

	@GetMapping("/login")
	public String loginView() {
		logger.info("로그인 페이지 이동");
		return "member/login";
	}

	@PostMapping("/login")
	public String login(String id, String pw, boolean saveRequest, boolean autoLogin, HttpSession session, Model model,
			HttpServletResponse response, RedirectAttributes rttr) {
		member member = dao.login(id);
		logger.info("로그인 시도" + "id->"+id+" pw->"+pw);
		logger.info("로그인 시도 확인 : "+member);
		if (member == null) {
			rttr.addFlashAttribute("notice", "없는 아이디 입니다.");
			return "redirect:/login";
		}

		if (member.getPw().equals(pw)) {
			session.setAttribute("member", member);
			if (saveRequest) {
				Cookie idCookie = new Cookie("savedId", member.getId());
				idCookie.setMaxAge(3600);
				response.addCookie(idCookie);
			} else {
				Cookie idCookie = new Cookie("savedId", null);
				idCookie.setMaxAge(0);
				response.addCookie(idCookie);
			}
			
			if (autoLogin) {
				Cookie pwCookie = new Cookie("savedPw", member.getPw());
				pwCookie.setMaxAge(3600);
				response.addCookie(pwCookie);
			} else {
				Cookie pwCookie = new Cookie("savedPw", null);
				pwCookie.setMaxAge(0);
				response.addCookie(pwCookie);
			}
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("notice", "패스워드가 잘못되었습니다.");
			return "redirect:/login";
		}

	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
		logger.info("로그아웃 처리");
		Cookie idCookie = new Cookie("savedId", null);
		idCookie.setMaxAge(0);
		response.addCookie(idCookie);
		
		Cookie pwCookie = new Cookie("savedPw", null);
		pwCookie.setMaxAge(0);
		response.addCookie(pwCookie);
		
		session.invalidate();
		return "redirect:/";
	}
	
//	@PostMapping("/check")
//	public String check(member member, Model model) {
//		logger.info("아이디 중복확인");
//		int result = dao.check(member);
//		if(result == 0) {
//			model.addAttribute("result", result);
//			model.addAttribute("member", member);
//		}else {
//			model.addAttribute("result", result);
//			model.addAttribute("member", member);
//		}
//		return "member/idCheck";
//	}
	
	@PostMapping("/check")
	public @ResponseBody int check(String id) {
		logger.info("아이디 중복확인 : "+id);
		member member = new member();
		member.setId(id);
		int result = dao.check(member);
		System.out.println(result);
		return result;
	}
	
	@GetMapping("/idCheck")
	public String idCheck() {
		logger.info("아이디 중복확인 페이지 이동");
		return "member/idCheck";
	}


	@GetMapping("/modify")
	public String modify() {
		logger.info("회원 정보 수정 페이지 이동");
		return "member/modify";
	}
	

	@PostMapping("/modify")
	public String modify(HttpSession session, HttpServletResponse response, member m) {
		logger.info("회원 정보 수정 : "+m);
		dao.update(m);
		Cookie pwCookie = new Cookie("savedPw", m.getPw());
		Cookie idCookie = new Cookie("savedId", m.getId());
		idCookie.setMaxAge(3600);
		response.addCookie(idCookie);
		pwCookie.setMaxAge(3600);
		response.addCookie(pwCookie);
		return "redirect:/";
	}
}
