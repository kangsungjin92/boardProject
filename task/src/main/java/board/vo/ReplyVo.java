package board.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ReplyVo {
	int reply_no;
	int board_no;
	String reply_content; //200����
	String reply_password; //50����
	Date regdate;
	int ref;
	int step;
	int depth;
}
