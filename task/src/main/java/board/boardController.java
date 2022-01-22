package board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.PortableInterceptor.ClientRequestInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.service.boardService;
import board.vo.BoardVo;
import board.vo.ReplyVo;

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
	public ModelAndView board(@RequestParam(required = false) Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		List<BoardVo> boardList;
		if (pageNum == null) {
			pageNum = 1;
		}
		int page = pageNum;

		Criteria cri = new Criteria();
		cri.setPage(page);
		cri.setPageStart();

		int boardCnt = service.getBoardCountService();
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(boardCnt);

		boardList = service.getBoardListService(cri);
		
		for(BoardVo vo : boardList) {
			System.out.println("������ Ÿ��Ʋ ���� : "+vo.getBoard_title());
		}

		mav.addObject("pageNum", pageNum);
		mav.addObject("cri", cri);
		mav.addObject("pm", pm);
		mav.addObject("boardList", boardList);
		mav.addObject("boardCnt", boardCnt);
		mav.setViewName("board");
		return mav;
	}

	@RequestMapping("boardWrite.do")
	public ModelAndView boardWrite(@RequestParam(required = false) Integer board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();
		if (board_no == null) {
			mav.setViewName("writeBoard");
		} else {
			mav.setViewName("redirect:/replyBoard.do?board_no=" + board_no + "&pageNum=" + pageNum);
			return mav;
		}
		mav.addObject("pageNum", pageNum);

		return mav;
	}

	@RequestMapping("boardWriteProc.do")
	public ModelAndView writeProc(BoardVo vo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("board_title : " + vo.getBoard_title());
		System.out.println("board_content : " + vo.getBoard_content());
		service.writeBoardService(vo);
		mav.setViewName("redirect:/board.do?pageNum=1");
		return mav;
	}

	@RequestMapping("getContentProc.do")
	public ModelAndView getContentProc(int board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("redirect:/getContent.do?board_no=" + board_no + "?pageNumber=" + pageNum);
		return mav;
	}

	@RequestMapping("getContent.do")
	public ModelAndView getContent(int board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();
		BoardVo vo = service.getContentService(board_no);
		List<ReplyVo> replyVo = service.getRepliesService(vo);
		for (ReplyVo re : replyVo) {
			System.out.println("������ ��� : " + re.getReply_content());
		}
		System.out.println("������ �Խù� ���� : " + vo.getBoard_title());
		mav.addObject("replyList", replyVo);
		mav.addObject("pageNum", pageNum);
		mav.addObject("content", vo);
		mav.setViewName("getContent");
		return mav;
	}

	@RequestMapping("deleteBoard.do")
	public ModelAndView deleteBoard(int pageNum, int board_no, String reply) {
		ModelAndView mav = new ModelAndView();
		BoardVo vv = service.getContentService(board_no);
		System.out.println("������ ���� step : "+vv.getStep());
		System.out.println("������ ���� depth : "+vv.getDepth());
		
		//null�̶�� ����� ���� ����� ���� ����
		BoardVo paramVo = service.getStepDepthForDeleteService(vv);
		if (paramVo != null) {//null�� �ƴ϶�� ����� �����ϹǷ� ���� �Ұ�
			System.out.println("���� �Ұ�");
			service.deleteWithReplyService(board_no);
			service.deleteCommentWithDeletingBoardService(board_no);
		} else {
			System.out.println("���� ����");
			service.deleteService(board_no);
			service.deleteCommentWithDeletingBoardService(board_no);
		}
		mav.setViewName("redirect:/board.do?pageNum=" + pageNum);
		return mav;
	}

	@RequestMapping("replyBoard.do")
	public ModelAndView modifyBoard(int board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();
		BoardVo vo = service.getContentService(board_no);
		mav.addObject("content", vo);
		mav.addObject("pageNum", pageNum);

		mav.setViewName("boardReply");
		return mav;
	}

	@RequestMapping("boardReplyProc.do")
	public ModelAndView boardReplyProc(BoardVo vo, int pageNum) {
		System.out.println(vo.getBoard_no());
		ModelAndView mav = new ModelAndView();

		BoardVo paramVo = service.getRefStepDepthService(vo);

		vo.setRef(paramVo.getRef());
		vo.setStep(paramVo.getStep());
		vo.setDepth(paramVo.getDepth());

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("ref", paramVo.getRef());
		map.put("step", paramVo.getStep());
		service.stepUpService(map);

		vo.setStep(vo.getStep() + 1);
		vo.setDepth(vo.getDepth() + 1);
		System.out.println("111111111111111");

		service.ReplyCountUpService(vo);

		service.writeReplyService(vo);
		mav.setViewName("redirect:/board.do?pageNum=" + pageNum);

		return mav;
	}

	@RequestMapping("chkPassword.do") // ��й�ȣ Ȯ�� �������� �̵��ϴ� �޼���
	public ModelAndView chkPassword(int board_no, int pageNum, String reply) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chkPassword");
		mav.addObject("reply", reply);
		mav.addObject("board_no", board_no);
		mav.addObject("pageNum", pageNum);
		return mav;
	}

	@ResponseBody
	@RequestMapping("chkPasswordProc.do") // ��й�ȣ�� Ȯ�����ִ� �޼���
	public BoardVo chkPasswordProc(int board_no, int pageNum, String board_password, String reply) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("pageNum", pageNum);
		map.put("board_password", board_password);
		map.put("reply", reply);
		BoardVo vo = service.checkPasswordService(map);
		try {
			System.out.println(vo.getBoard_password());
		} catch (NullPointerException e) {
			BoardVo VO = new BoardVo();
			VO.setBoard_password(
					"098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321");
			return VO;
		}
		return vo;
	}

	@RequestMapping("modifyContent.do")
	public ModelAndView modify(BoardVo vo, int pageNum) {
		ModelAndView mav = new ModelAndView();
		BoardVo returnVo = service.getContentService(vo.getBoard_no());
		mav.addObject("content", returnVo);
		mav.addObject("pageNum", pageNum);
		mav.setViewName("chkPasswordModify");
		return mav;
	}

	@RequestMapping("chkPasswordModify.do")
	@ResponseBody
	public BoardVo chkPasswordModify(int board_no, int pageNum, String board_password) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("pageNum", pageNum);
		map.put("board_password", board_password);
		BoardVo vo = service.checkPasswordService(map);
		try {
			System.out.println(vo.getBoard_password());
		} catch (NullPointerException e) {
			BoardVo VO = new BoardVo();
			VO.setBoard_password(
					"098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321");
			return VO;
		}
		return vo;
	}

	@RequestMapping("modify.do")
	public ModelAndView modify(int board_no, int pageNum) {
		ModelAndView mav = new ModelAndView();
		BoardVo vo = service.getContentService(board_no);
		mav.addObject("content", vo);
		mav.addObject("pageNum", pageNum);
		mav.setViewName("modify");
		return mav;
	}

	@RequestMapping("modifyProc.do")
	public ModelAndView modifyProc(int pageNum, BoardVo vo) {
		ModelAndView mav = new ModelAndView();
		service.modifyContentService(vo);
		mav.setViewName("redirect:/getContent.do?pageNum=" + pageNum + "&board_no=" + vo.getBoard_no());
		return mav;
	}

	@RequestMapping("search.do")
	public ModelAndView search(Integer pageNum, String search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
		Criteria cri = new Criteria();
		PageMaker pm = new PageMaker();

		if (pageNum == null) {
			pageNum = 1;
		}
		int count = service.searchCountService(search);

		cri.setPage(pageNum);
		cri.setPageStart();

		pm.setCri(cri);
		pm.setTotalCount(count);

		map.put("startRow", cri.getStartRow());
		map.put("search", search);

		List<BoardVo> boardList = service.searchService(map);

		for (BoardVo vo : boardList) {
			System.out.println(vo.getBoard_title());
		}

		mav.addObject("cri", cri);
		mav.addObject("pm", pm);
		mav.addObject("boardList", boardList);
		mav.addObject("count", count);
		mav.addObject("search", search);
		mav.setViewName("searchBoard");
		return mav;
	}

	@RequestMapping("writeReply.do")
	public ModelAndView writeReply(int pageNum, ReplyVo vo, int board_no) {
		System.out.println("vo.getReplyWriter : " + vo.getReply_writer());
		System.out.println("vo.getReplyContent : " + vo.getReply_content());
		System.out.println("vo.getReplyPassword : " + vo.getReply_password());
		ModelAndView mav = new ModelAndView();
		service.writeReplyService(vo);
		service.replyCountUpService(board_no);
		System.out.println("write reply board_no : " + vo.getBoard_no());
		mav.addObject("pageNum", pageNum);
		mav.addObject("content", vo);
		mav.setViewName("redirect:/getContent.do?pageNum=" + pageNum + "&board_no=" + vo.getBoard_no());

		return mav;
	}

	@RequestMapping("modifyReply")
	public ModelAndView modifyReply(int pageNum, int board_no, int reply_no) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("board_no", board_no);
		mav.addObject("reply_no", reply_no);
		mav.addObject("pageNum", pageNum);
		mav.setViewName("modifyReplyPassword");
		return mav;
	}

	@ResponseBody
	@RequestMapping("chkPasswordReplyProc.do") // ��й�ȣ�� Ȯ�����ִ� �޼���
	public ReplyVo chkPasswordReplyProc(int board_no, int pageNum, String reply_password, int reply_no) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("pageNum", pageNum);
		map.put("reply_password", reply_password);
		map.put("reply_no", reply_no);
		ReplyVo vo = service.replyModifyProcService(map);
		try {
			System.out.println("���񽺸� ���� ������ reply�� ��й�ȣ  : " + vo.getReply_password());
		} catch (NullPointerException e) {
			ReplyVo VO = new ReplyVo();
			VO.setReply_password(
					"098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321");
			return VO;
		}
		return vo;
	}

	@RequestMapping("modifyReplyPage")
	public ModelAndView modifyReplyPage(int board_no, int pageNum, int reply_no) {
		ModelAndView mav = new ModelAndView();
		System.out.println("�Ѱ��ִ� board_no : " + board_no);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_no", board_no);
		map.put("reply_no", reply_no);
		ReplyVo vo = service.getReplyService(map);
		System.out.println(1);
		System.out.println("������ ���� replyVo.writer : "+vo.getReply_writer());
		System.out.println("������ ���� replyVo.content : "+vo.getReply_content());
		mav.addObject("vo", vo);
		mav.addObject("board_no", board_no);
		mav.addObject("pageNum", pageNum);
		mav.addObject("reply_no", reply_no);
		mav.setViewName("replyModifyPage");
		return mav;
	}

	@RequestMapping("replyUpdate")
	public ModelAndView replyUpdate(int pageNum, int board_no, int reply_no, String reply_content, String reply_writer) {
		ModelAndView mav = new ModelAndView();
		System.out.println("������ ���� reply_writer : "+reply_writer);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("reply_no", reply_no);
		map.put("reply_content", reply_content);
		map.put("reply_writer", reply_writer);
		service.replyUpdateService(map);

		mav.setViewName("redirect:/getContent.do?pageNum=" + pageNum + "&board_no=" + board_no);
		return mav;
	}

	@RequestMapping("deleteReply.do")
	public ModelAndView deleteReply(int pageNum, int board_no, int reply_no) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNum", pageNum);
		mav.addObject("board_no", board_no);
		mav.addObject("reply_no", reply_no);
		mav.setViewName("deleteReplyChk");
		return mav;
	}

	@ResponseBody
	@RequestMapping("deleteReplyPasswordChk.do") // ��й�ȣ�� Ȯ�����ִ� �޼���
	public ReplyVo deleteReplyPasswordChk(int board_no, int pageNum, String reply_password, int reply_no) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("pageNum", pageNum);
		map.put("reply_password", reply_password);
		map.put("reply_no", reply_no);
		ReplyVo vo = service.replyModifyProcService(map);
		try {
			System.out.println("���񽺸� ���� ������ reply�� ��й�ȣ  : " + vo.getReply_password());
		} catch (NullPointerException e) {
			ReplyVo VO = new ReplyVo();
			VO.setReply_password(
					"098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321");
			return VO;
		}
		return vo;
	}

	@RequestMapping("deleteProc.do")
	public ModelAndView deleteProc(int pageNum, int board_no, int reply_no) {
		ModelAndView mav = new ModelAndView();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_no", board_no);
		map.put("reply_no", reply_no);
		System.out.println("�ʿ� ���� board_no : " + board_no);
		System.out.println("�ʿ� ���� reply_no : " + reply_no);
		service.deleteReplyService(map);
		service.replyCountDownService(board_no);
		System.out.println("��� ���� �Ϸ�");
		mav.setViewName("redirect:/getContent.do?board_no=" + board_no + "&pageNum=" + pageNum);
		return mav;
	}
}
