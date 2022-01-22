package board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import board.Criteria;
import board.dao.BoardDao;
import board.vo.BoardVo;
import board.vo.ReplyVo;

@Service("boardService")
public class BoardServiceImpl implements boardService {
	@Autowired
	BoardDao dao;
	
	
	@Override
	public Integer getBoardCountService() {
		return dao.getBoardCount();
	}
	@Override
	public List<BoardVo> getBoardListService(Criteria cri) {
		return dao.getBoardListDao(cri);
	}
	@Override
	public void writeBoardService(BoardVo vo) {
		dao.writeBoardDao(vo);
	}
	@Override
	@Transactional
	public BoardVo getContentService(int board_no) {
		BoardVo vo = dao.getContentDao(board_no);
		dao.addViewCntDao(board_no);
		return vo;
	}
	@Override
	@Transactional
	public void deleteService(int board_no) {
		dao.deleteReplyWIthDeleteContentDao(board_no);
		dao.deleteDao(board_no);
	}
	@Override
	@Transactional
	public void deleteWithReplyService(int board_no) {
		dao.deleteReplyWIthDeleteContentDao(board_no);
		dao.deleteWithReplyDao(board_no);
	}
	@Override
	public BoardVo checkPasswordService(Map<String, Object> map) {
		return dao.checkPasswordDao(map);
	}
	@Override//ref step depth를 가지고와주는 메서드
	public BoardVo getRefStepDepthService(BoardVo vo) {
		return dao.getRefStepDepthDao(vo);
	}
	@Override
	public void stepUpService(Map<String, Integer> map) {
		dao.stepUpDao(map);
	}
	@Override
	public void selfStepUpService(BoardVo vo) { //자신의 step을 올려주는 메서드
		dao.selfStepUpDao(vo);
	}
	@Override
	public void writeReplyService(BoardVo vo) {
		dao.writeReplyDao(vo);
	}
	
	@Override
	public void processUp() {
		dao.processUpDao();
	}
	
	
	@Override
	@Transactional
	public void writeReply(BoardVo vo) {
		BoardVo paramVo = this.getRefStepDepthService(vo);//ref, step, depth를 받아온다
		System.out.println("paramVo.getRef : "+paramVo.getRef());
		System.out.println("paramVo.getStep : "+paramVo.getStep());
		System.out.println("paramVo.getDepth : "+paramVo.getDepth());
		vo.setRef(paramVo.getRef());//복사해온 ref step depth들을 vo에 set
		vo.setStep(paramVo.getStep());
		vo.setDepth(paramVo.getDepth());
		
		Map<String, Integer> map = new HashMap<String, Integer>();//stepup 메서드를 위한 맵 생성
		map.put("ref", vo.getRef());
		map.put("step", vo.getStep());
		
		this.stepUpService(map);//이 메서드를 사용함으로써, 같은 ref 그룹 내에서 자신보다 step이 높은것들의 step값을 +1 해준다
		
		this.selfStepUpService(vo);//vo의 board_no를 파라미터로 주며, board_no를 찾아가 자신의 step값을 +1 해준다
		
		this.writeReplyService(vo);//일단 먼저 올린다(왜냐하면 디비에 데이터가 있어야 아래 행위들을 진행할 수 있기때문)
		
		
		
		
		
	}
	@Override
	public void modifyContentService(BoardVo vo) {
		dao.modifyContentDao(vo);
	}
	@Override
	public void replyOrNotService(BoardVo vo) {
		dao.replyOrNotDao(vo);
	}
	
	@Override
	public void killSevice(int board_no) {
		dao.killDao(board_no);
	}
	@Override
	public List<BoardVo> searchService(Map<String, Object> map) {
		return dao.searchDao(map);
	}
	@Override
	public Integer searchCountService(String search) {
		return dao.searchCountDao(search);
	}
	@Override
	public void writeReplyService(ReplyVo vo) {
		dao.writeReplyDao(vo);
	}
	@Override
	public List<ReplyVo> getRepliesService(BoardVo vo) {
		return dao.getRepliesDao(vo);
	}
	@Override
	public ReplyVo replyModifyProcService(Map<String, Object> map) {
		return dao.replyModifyProcDao(map);
	}
	@Override
	public void replyUpdateService(Map<String, Object> map) {
		dao.replyUpdateDao(map);
	}
	@Override
	public void deleteReplyService(Map<String, Integer> map) {
		dao.deleteReplyDao(map);
	}
	@Override
	public void ReplyCountUpService(BoardVo vo) {
		dao.ReplyCountUpDao(vo);
	}
	@Override
	public BoardVo getStepDepthForDeleteService(BoardVo vo) {
		return dao.getStepDepthForDeleteDao(vo);
	}
	@Override
	public void deleteCommentWithDeletingBoardService(int board_no) {
		dao.deleteCommentWithDeletingBoardDao(board_no);
	}
	@Override
	public int getReplyCountService(int board_no) {
		return dao.getReplyCountDao(board_no);
	}
	@Override
	public void replyCountUpService(int board_no) {
		dao.replyCountUpDao(board_no);
	}
	@Override
	public void replyCountDownService(int board_no) {
		dao.replyCountDownDao(board_no);
	}
	@Override
	public ReplyVo getReplyService(Map<String, Integer> map) {
		return dao.getReplyDao(map);
	}
	
	
	
	
	

}
