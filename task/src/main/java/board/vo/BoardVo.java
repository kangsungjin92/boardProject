package board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVo {
	int board_no;
	String board_title;
	String board_content;
	Date board_regdate;
	int viewCnt;
	int ref;
	int step;
	int depth;
	int rnum;
	String board_password;
}
