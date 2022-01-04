package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import board.vo.UserVo;

@Controller
public class boardController {

	@RequestMapping("logout.do")
	public ModelAndView logout(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession(false);
		session.invalidate();
		mav.setViewName("login");
		
		return mav;
	}
	
	@RequestMapping("board.do")
	public ModelAndView board(HttpServletRequest req, int pageNum) {
		ModelAndView mav = new ModelAndView();
		
		return mav;
	}
	
	
}
