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
	@Override//ref step depth�� ��������ִ� �޼���
	public BoardVo getRefStepDepthService(BoardVo vo) {
		return dao.getRefStepDepthDao(vo);
	}
	@Override
	public void stepUpService(Map<String, Integer> map) {
		dao.stepUpDao(map);
	}
	@Override
	public void selfStepUpService(BoardVo vo) { //�ڽ��� step�� �÷��ִ� �޼���
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
		BoardVo paramVo = this.getRefStepDepthService(vo);//ref, step, depth�� �޾ƿ´�
		System.out.println("paramVo.getRef : "+paramVo.getRef());
		System.out.println("paramVo.getStep : "+paramVo.getStep());
		System.out.println("paramVo.getDepth : "+paramVo.getDepth());
		vo.setRef(paramVo.getRef());//�����ؿ� ref step depth���� vo�� set
		vo.setStep(paramVo.getStep());
		vo.setDepth(paramVo.getDepth());
		
		Map<String, Integer> map = new HashMap<String, Integer>();//stepup �޼��带 ���� �� ����
		map.put("ref", vo.getRef());
		map.put("step", vo.getStep());
		
		this.stepUpService(map);//�� �޼��带 ��������ν�, ���� ref �׷� ������ �ڽź��� step�� �����͵��� step���� +1 ���ش�
		
		this.selfStepUpService(vo);//vo�� board_no�� �Ķ���ͷ� �ָ�, board_no�� ã�ư� �ڽ��� step���� +1 ���ش�
		
		this.writeReplyService(vo);//�ϴ� ���� �ø���(�ֳ��ϸ� ��� �����Ͱ� �־�� �Ʒ� �������� ������ �� �ֱ⶧��)
		
		
		
		
		
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
	
	
	
	
	

}
