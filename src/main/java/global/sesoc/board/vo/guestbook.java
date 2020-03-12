package global.sesoc.board.vo;

import lombok.Data;

@Data
public class guestbook {
	private int seqno;
	private String guestname;
	private String guestpwd;
	private String regdate;
	private String text;
}
