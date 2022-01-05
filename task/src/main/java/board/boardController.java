package board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import board.service.boardService;
import board.vo.BoardVo;
import board.vo.UserVo;

@Controller
public class boardController {
	@Autowired
	boardService service;
	/*
	 * @RequestMapping("logout.do") public ModelAndView logout(HttpServletRequest
	 * req) { ModelAndView mav = new ModelAndView(); HttpSession session =
	 * req.getSession(false); session.invalidate(); mav.setViewName("login");
	 * 
	 * return mav; }
	 */
	
	@RequestMapping("board.do")
	public ModelAndView board(@RequestParam(required=false) Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		List<BoardVo> boardList;
		System.out.println("현재 페이지 : "+ pageNum.toString());
		if(pageNum == null) {
			pageNum=1;
		}
		int page = pageNum;
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		cri.setPageStart();
		System.out.println("cri.getPage : "+cri.getPage());
		System.out.println("cri.getPerPageNum : "+cri.getPerPageNum());
		System.out.println("cri.getStartRow : "+cri.getStartRow());
		
		int boardCnt = service.getBoardCountService();
		System.out.println("boardCnt : "+ boardCnt);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(boardCnt);
		System.out.println("startPgae : "+pm.getStartPage());
		System.out.println("endPgae : "+pm.getEndPage());

		boardList = service.getBoardListService(cri);
		
		mav.addObject("cri", cri);
		mav.addObject("pm", pm);
		mav.addObject("boardList", boardList);
		mav.addObject("boardCnt", boardCnt);
		mav.setViewName("board");
		return mav;
	}
	
	@RequestMapping("boardWrite")
	public ModelAndView boardWrite(@RequestParam(required=false) Integer board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();
		if(board_no == null) {
			mav.setViewName("writeBoard");
		}else {
			mav.setViewName("redirect:/jin/board.do?board_no="+board_no);
		}
		mav.addObject("pageNum", pageNum);
		
		return mav;
	}
	
	
}
