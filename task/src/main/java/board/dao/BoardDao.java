package board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.Criteria;
import board.vo.BoardVo;
import board.vo.ReplyVo;

@Repository
public class BoardDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public Integer getBoardCount() {
		Integer cnt = sqlSessionTemplate.selectOne("boardMapper.getBoardCnt");
		if(cnt == null) {
			cnt = 0;
		}
		System.out.println("dao에서의 개수 "+cnt);
		return cnt;
	}
	
	public List<BoardVo> getBoardListDao(Criteria cri){
		return sqlSessionTemplate.selectList("boardMapper.getBoardListMapper", cri);
	}
	
	public void writeBoardDao(BoardVo vo) {
		sqlSessionTemplate.insert("boardMapper.writeBoard", vo);
	}
	
	public BoardVo getContentDao(int board_no) {
		return sqlSessionTemplate.selectOne("boardMapper.getContent", board_no);
	}
	
	public void addViewCntDao(int board_no) {
		sqlSessionTemplate.update("boardMapper.addViewCnt", board_no);
	}
	public void deleteDao(int board_no) {
		sqlSessionTemplate.delete("boardMapper.delete", board_no);
	}
	
	public void deleteWithReplyDao(int board_no) {
		sqlSessionTemplate.update("boardMapper.deleteWithReply", board_no);
	}
	
	public BoardVo checkPasswordDao(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("boardMapper.checkPassword", map);
	}
	
	public BoardVo getRefStepDepthDao(BoardVo vo) {//ref, step, depth를 가지고 와주는 메서드
		return sqlSessionTemplate.selectOne("boardMapper.getRefStepDepth", vo);
	}
	
	public void stepUpDao(Map<String, Integer> map) {//자신의 step보다 높은 step들을 1씩 증가
		sqlSessionTemplate.update("boardMapper.stepUp", map);
	}
	
	public void selfStepUpDao(BoardVo vo) {
		sqlSessionTemplate.update("boardMapper.selfStepUp", vo);
	}
	
	public void writeReplyDao(BoardVo vo) {
		sqlSessionTemplate.insert("boardMapper.writeReply", vo);
	}
	
	public void processUpDao() {
		sqlSessionTemplate.update("boardMapper.processUp", 300);
	}
	
	public void modifyContentDao(BoardVo vo) {
		sqlSessionTemplate.update("boardMapper.modifyContent", vo);
	}
	
	public void replyOrNotDao(BoardVo vo) {
		sqlSessionTemplate.update("boardMapper.replyOrNot", vo);
	}
	
	public void killDao(int board_no) {
		sqlSessionTemplate.update("boardMapper.kill", board_no);
	}
	
	public List<BoardVo> searchDao(Map<String, Object> map){
		return sqlSessionTemplate.selectList("boardMapper.search", map);
	}
	
	public Integer searchCountDao(String search) {
		return sqlSessionTemplate.selectOne("boardMapper.searchCount", search);
	}
	
	public void writeReplyDao(ReplyVo vo) {
		sqlSessionTemplate.insert("boardMapper.writeReplyInContent", vo);
	}
	
	public List<ReplyVo> getRepliesDao(BoardVo vo) {
		return sqlSessionTemplate.selectList("boardMapper.getReplies", vo);
	}
	
	public ReplyVo replyModifyProcDao(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("boardMapper.replyModifyProc", map);
	}
	
	public void replyUpdateDao(Map<String, Object> map) {
		sqlSessionTemplate.update("boardMapper.replyUpdate", map);
	}
	
	public void deleteReplyDao(Map<String, Integer> map) {
		sqlSessionTemplate.delete("boardMapper.deleteReply", map);
	}
	
	public void deleteReplyWIthDeleteContentDao(int board_no) {
		sqlSessionTemplate.delete("boardMapper.deleteReplyWIthDeleteContent", board_no);
	}
	
	public void ReplyCountUpDao(BoardVo vo) {
		sqlSessionTemplate.update("boardMapper.ReplyCountUp", vo);
	} 
	
	public BoardVo getStepDepthForDeleteDao(BoardVo vo) {
		return sqlSessionTemplate.selectOne("boardMapper.getStepDepthForDelete", vo);
	}
	
	public void deleteCommentWithDeletingBoardDao(int board_no) {
		sqlSessionTemplate.delete("boardMapper.deleteCommentWithDeletingBoard", board_no);
	}
	
	public int getReplyCountDao(int board_no) {
		return sqlSessionTemplate.selectOne("boardMapper.getReplyCount", board_no);
	}
	
	public void replyCountUpDao(int board_no) {
		sqlSessionTemplate.update("boardMapper.replyCountUp", board_no);
	}
	
	public void replyCountDownDao(int board_no) {
		sqlSessionTemplate.update("boardMapper.replyCountDown", board_no);
	}
	
	public ReplyVo getReplyDao(Map<String, Integer> map) {
		return sqlSessionTemplate.selectOne("boardMapper.getReply", map);
	}
}
