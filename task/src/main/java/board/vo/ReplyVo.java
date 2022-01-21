package board.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ReplyVo {
	int reply_no;
	int board_no;
	String reply_writer;
	String reply_content; //200글자
	String reply_password; //50글자
	Date regdate;
	int ref;
	int step;
	int depth;
}
