package board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.vo.UserVo;

@Repository
public class UserDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public void signUpDao(UserVo vo) {
		sqlSessionTemplate.insert("userDaoMapper.signUpMapper", vo);
	}
	
	public UserVo loginValidationDao(UserVo vo) {
		return sqlSessionTemplate.selectOne("userDaoMapper", vo);
	}
}
