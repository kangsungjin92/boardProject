package board.service;

import java.util.List;

import board.Criteria;
import board.vo.BoardVo;

public interface boardService {
	public Integer getBoardCountService();
	public List<BoardVo> getBoardListService(Criteria cri);
}
