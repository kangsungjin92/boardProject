package board.service;

import board.vo.UserVo;

public interface UserService {
	public void signUpService(UserVo vo);
	public UserVo loginValidationService(UserVo vo);
}
