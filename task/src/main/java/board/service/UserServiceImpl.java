package board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.UserDao;
import board.vo.UserVo;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;

	@Override
	public void signUpService(UserVo vo) {
		dao.signUpDao(vo);
	}

	@Override
	public UserVo loginValidationService(UserVo vo) {
		return dao.loginValidationDao(vo);
	}

	
	

}
