package board.service;

import java.util.List;
import java.util.Map;

import board.Criteria;
import board.vo.BoardVo;
import board.vo.ReplyVo;

public interface boardService {
	public Integer getBoardCountService();
	public List<BoardVo> getBoardListService(Criteria cri);
	public void writeBoardService(BoardVo vo);
	public BoardVo getContentService(int board_no);
	public void deleteService(int board_no);
	public void deleteWithReplyService(int board_no);
	public BoardVo checkPasswordService(Map<String, Object> map);
	public BoardVo getRefStepDepthService(BoardVo vo);
	public void stepUpService(Map<String, Integer> map);
	public void selfStepUpService(BoardVo vo);
	public void writeReplyService(BoardVo vo);
	public void writeReply(BoardVo vo);
	public void processUp();
	public void modifyContentService(BoardVo vo);
	public void replyOrNotService(BoardVo vo);
	public void killSevice(int board_no);
	public List<BoardVo> searchService(Map<String, Object> map);
	public Integer searchCountService(String search);
	public void writeReplyService(ReplyVo vo);
	public List<ReplyVo> getRepliesService(BoardVo vo);
	public ReplyVo replyModifyProcService(Map<String, Object> map);
	public void replyUpdateService(Map<String, Object> map);
	public void deleteReplyService(Map<String, Integer> map);
	public void ReplyCountUpService(BoardVo vo);
	public BoardVo getStepDepthForDeleteService(BoardVo vo);
	public void deleteCommentWithDeletingBoardService(int board_no);
	public int getReplyCountService(int board_no);
	public void replyCountUpService(int board_no);
	public void replyCountDownService(int board_no);
}
