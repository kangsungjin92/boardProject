package board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.Criteria;
import board.vo.BoardVo;

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
}
