package board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.service.UserService;
import board.vo.UserVo;

@Controller
public class UserController {
	@Autowired
	UserService service;
	
	@RequestMapping("login.do")
	public ModelAndView login(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession(false);
		if(session!=null) {
			mav.setViewName("redirect:/board.do?pageNum=1");
			return mav;
		}else {
			mav.setViewName("login");
			return mav;
		}
	}
	
	@RequestMapping("loginWithoutId")
	public ModelAndView loginWithoutId(HttpServletRequest req){
		ModelAndView mav = new ModelAndView();
		String ip = req.getHeader("X-Forwarded-For");
		HttpSession session = req.getSession(true);
		session.setAttribute("ip", ip);
		if(ip==null) {
			ip = req.getRemoteAddr();
			session.setAttribute("ip", ip);
		}
		mav.setViewName("redirect:/board.do?pageNum=1");
		return mav;
	}
	
	@RequestMapping("signUp.do")
	public ModelAndView signUp() {
		ModelAndView mav = new ModelAndView();
		System.out.println("회원가입 페이지로 이동");
		mav.setViewName("signUp");
		return mav;
	}
	
	@RequestMapping("signUpProc.do")
	public ModelAndView signUpProc(HttpServletRequest req, UserVo vo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("아이디 : "+vo.getUser_id());
		System.out.println("비밀번호 : "+vo.getUser_password());
		service.signUpService(vo);
		HttpSession session = req.getSession(true);
		session.setAttribute("id", vo.getUser_id());
		session.setAttribute("user_no", vo.getUser_no());
		mav.setViewName("redirect:/jin/board?pageNum=1");
		return mav;
	}
	
	@RequestMapping("loginProc.do")
	public ModelAndView loginProc(UserVo vo, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		UserVo returnVo = service.loginValidationService(vo);
		if(returnVo!=null) {
			HttpSession session = req.getSession();
			session.setAttribute("id", returnVo.getUser_id());
			session.setAttribute("user_no", returnVo.getUser_id());
			mav.setViewName("redirect:/board.do?pageNum=1");
			return mav;
		}
		mav.setViewName("login");
		return mav;
	}
	

}
