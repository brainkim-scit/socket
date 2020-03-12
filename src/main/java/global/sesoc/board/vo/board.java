package global.sesoc.board.vo;

import lombok.Data;

@Data
public class board {
	
	private int count;
	private int boardno;
	private String writer;
	private String title;
	private String content;
	private String regdate;
	private int hitcount;
	private String originalfilename;
	private String savedfilename;
}
