package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.Criteria;
import board.dao.BoardDao;
import board.vo.BoardVo;

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
	
	

}
