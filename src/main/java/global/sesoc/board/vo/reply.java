package global.sesoc.board.vo;

import lombok.Data;

@Data
public class reply {

	private int replyno;
	private String writer;
	private String regdate;
	private String replytext;
	private int boardno;
}
